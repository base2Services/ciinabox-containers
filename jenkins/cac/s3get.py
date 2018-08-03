#!/usr/bin/python2.7
import urllib2
import os
import json
from urlparse import urlparse
import datetime
from hashlib import sha1
import hmac
import base64
response = urllib2.urlopen('http://169.254.169.254/latest/meta-data/iam/security-credentials/' + os.environ['IAM_ROLE'])
data = json.load(response)
urlin = urlparse(sys.argv[1])
bucket = urlin.netloc
file = urlin.path
url = "http://" + bucket + '.s3.amazonaws.com/' + file
req = urllib2.Request(url)
resource = "/"+bucket+"/"+file
contentType="application/x-compressed-tar"
date = datetime.datetime.utcnow()
datestr = date.strftime('%a, %d %b %Y %H:%M:%S GMT')
sv ="GET"+ "\n"+ "\n"+ contentType+ "\n"+ datestr + "\nx-amz-security-token:" + data['Token'] + "\n"+ resource
sv8 = sv.encode('utf-8')
hashed = hmac.new(str(data['SecretAccessKey']),sv8, sha1)
signed = base64.b64encode(hashed.digest())
req.add_header('x-amz-security-token', data['Token'])
req.add_header('Date', datestr)
req.add_header('Content-Type', contentType)
req.add_header('Authorization', 'AWS ' + data['AccessKeyId'] + ':' + signed)
try:
    response = urllib2.urlopen(req)
    html = response.read()
    print html
except urllib2.HTTPError, e:
    sys.stderr.write ('HTTPError = ' + str(e.code))
    html = e.read()
    sys.stderr.write(html)
except urllib2.URLError, e:
    sys.stderr.write('URLError = ' + str(e.reason))
except httplib.HTTPException, e:
    sys.stderr.write('HTTPException')
except Exception:
    import traceback
    sys.stderr.write('generic exception: ' + traceback.format_exc())
