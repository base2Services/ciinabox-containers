import jenkins.model.*
import hudson.security.*


user = hudson.model.User.get('ciinabox')
user.setFullName('ciinabox')
email = new hudson.tasks.Mailer.UserProperty('ciinabox@base2services.com')
user.addProperty(email)
password = hudson.security.HudsonPrivateSecurityRealm.Details.fromPlainPassword('ciinabox')
user.addProperty(password)
user.save()


def instance = Jenkins.getInstance()
def realm = new HudsonPrivateSecurityRealm(false)
instance.setSecurityRealm(realm)
def strategy = new hudson.security.FullControlOnceLoggedInAuthorizationStrategy()
instance.setAuthorizationStrategy(strategy)
instance.save()
