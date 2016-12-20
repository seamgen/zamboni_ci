# zamboni_ci

A command line automation utility for fetching UDIDs from hockey and updating apple provisioning profiles.

##installation
zamboni_ci is packaged as a ruby gem. To install, start by pulling the repository

```
git clone GitHub.com
```

next build the gem

```
gem build zamboni_ci.gemspec
```

install the gem

```
gem install zamboni_ci-0.0.0.gem
```

##usage

```
zamboni_ci --h_app_id 123456 --prov_profile_name "Rocketing Development Profile" --apple_account applelogin@gmail.com --hockey_account hockeylogin@gmail.com
```
## parameters

### h\_app_id
The url id for the application on rink.hockey.com. 

```
https://rink.hockeyapp.net/manage/apps/444228
```

The app id for the above url is 444228

This is not the hex App Id value listed under the overview tab.

### prov\_profile_name
Name of the provisioning profile to update
### apple_account
login email for the apple provisioning profile

zamboni_ci looks for an existing internet password in your keychain for developer.apple.com. To add a keychain item:

```
security add-internet-password -s developer.apple.com -w PASSWORD
```

for more information see

```
man security
```


### hockey_account
login email for hockeyapp

zamboni_ci looks for an existing internet password in your keychain for rink.hockeyapp.com. To add a keychain item:

```
security add-internet-password -s rink.hockeyapp.com -w PASSWORD
```
>>>>>>> README
