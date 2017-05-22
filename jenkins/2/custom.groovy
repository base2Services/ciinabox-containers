import jenkins.*
import hudson.*
import com.cloudbees.plugins.credentials.*
import com.cloudbees.plugins.credentials.common.*
import com.cloudbees.plugins.credentials.domains.*
import com.cloudbees.plugins.credentials.impl.*
import hudson.plugins.sshslaves.*;
import jenkins.model.*
import hudson.model.*
import hudson.security.*
import hudson.slaves.*

def instance = Jenkins.getInstance()
instance.setNumExecutors(0)

def bootstrap = new File("/var/jenkins_home/bootstrap").exists()


user = hudson.model.User.get('ciinabox',false)

if(user == null && !bootstrap) {
  println("no ciinabox user found...creating it")
  user = hudson.model.User.get('ciinabox')
  user.setFullName('ciinabox')
  email = new hudson.tasks.Mailer.UserProperty('ciinabox@base2services.com')
  user.addProperty(email)
  password = hudson.security.HudsonPrivateSecurityRealm.Details.fromPlainPassword('ciinabox')
  user.addProperty(password)
  user.save()

  def realm = new HudsonPrivateSecurityRealm(false)
  instance.setSecurityRealm(realm)
  def strategy = new hudson.security.ProjectMatrixAuthorizationStrategy()
  strategy.add(Jenkins.ADMINISTER, "ciinabox")
  instance.setAuthorizationStrategy(strategy)
  instance.save()
} else {
    println("ciinabox user and default security already setup")
}


def creds = com.cloudbees.plugins.credentials.CredentialsProvider.lookupCredentials(
      com.cloudbees.plugins.credentials.common.StandardUsernameCredentials.class,
      Jenkins.instance,
      null,
      null
);

def jenkinsCreds = null
for (c in creds) {
  if(c.username == 'jenkins') {
    jenkinsCreds = c
    break
  }
}

if(jenkinsCreds == null) {
  global_domain = Domain.global()
  credentials_store =
  Jenkins.instance.getExtensionList(
  'com.cloudbees.plugins.credentials.SystemCredentialsProvider'
  )[0].getStore()
  jenkinsCreds = new UsernamePasswordCredentialsImpl(
  CredentialsScope.GLOBAL,
  null,
  "jenkins",
  "jenkins",
  "jenkins")
  credentials_store.addCredentials(global_domain, jenkinsCreds)
} else {
 println("jenkins creds already exists")
}

def envVars = [
  new EnvironmentVariablesNodeProperty.Entry('LANGUAGE','C.UTF-8'),
  new EnvironmentVariablesNodeProperty.Entry('LC_ALL','C.UTF-8')
]
envProps = new EnvironmentVariablesNodeProperty(envVars)

def defaultSlaveExists(){
  for (jenkinsSlave in hudson.model.Hudson.instance.slaves) {
    if ( jenkinsSlave.name.equals('jenkins-docker-slave') ) {
      return true
    }
  }
  false
}
  
def addSlave = !(defaultSlaveExists())
  if(addSlave) {  
  Jenkins.instance.addNode(new DumbSlave("jenkins-docker-slave","Jenkins Docker Slave","/home/jenkins","8",Node.Mode.NORMAL,"docker",
    new SSHLauncher("172.17.0.1",2223,jenkinsCreds,null,null,null,null,null,null,null,null),new RetentionStrategy.Always(),[envProps]))
}
if(!bootstrap) {
  println("touch /var/jenkins_home/bootstrap".execute().text)
} else {
  println("already bootstrap!!!!!")
}
