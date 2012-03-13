# rDrop: Dropbox interface via R

This package provides a  programmatic interface to [Dropbox](https://www2.dropbox.com/home) from the [R environment](http://www.r-project.org/).

> **Disclaimer: This package is currently in beta and we make no claims or warranties as to the safety of your Dropbox contents. Use at your own risk.**

Reference:
[Complete Dropbox API Reference.](https://www2.dropbox.com/developers/reference/api)


## Initial setup
(1) To begin, create an `App` on Dropbox from the [Dropbox Developer site](https://www2.dropbox.com/developers/apps). You will need to log in with your Dropbox username and password.

(2) Next, click `Create An App`.

![Create an app for your personal use on Dropbox](https://github.com/karthikram/rDrop/blob/master/screenshots/create_app.png?raw=true
)

(3) Name your personal version of this app. Dropbox requires that your app have a unique name. Dropbox [branding guidelines](https://www2.dropbox.com/developers/reference/branding) also prohibit the use of the word **"Dropbox"** or names that begin with "**Drop**". We recommend that you name the app something like "**Your_first_name_last_name_rDrop**" to avoid naming conflicts.


![Alt text](https://github.com/karthikram/rDrop/blob/master/screenshots/name_your_app.png?raw=true)

(4) Once you click create,copy your App key and App secret. If you use your `.rprofile` then we recommend that you save your keys there like so: <br>
`options(DropboxKey="Your_App_key")`<br>
`options(DropboxSecret="Your_App_secret")`
<br>

![Alt text](https://github.com/karthikram/rDrop/blob/master/screenshots/keys.png?raw=true)

If you prefer not to specify keys in a `.rprofile` (especially if you are on a public computer/cluster/cloud server), you can specify both keys in the `dropbox_auth()` function directly. Example: `dropbox_auth('dropbox_key', 'dropbox_secret') <em>Note that once you have authorized an app, there is no need to call this function again.</em> You can just use your saved credential file to access your Dropbox. If for any reason, the file becomes compromised, just revoke access from your [list of authorized apps.](https://www2.dropbox.com/account#applications)

### Authorizing your app
From within `R`, load `rDrop` first: <br>
<code><pre>
library(rDrop)
\# Does not work yet ...will add instructions to install using devtools once package is less buggy.
</pre></code>

 `dropbox_credentials <- dropbox_auth()`
 <br>
 If your keys are stored in your `.rprofile`, then there is no need to provide it to the function. If you don't have that setup, then use: <br>


 `dropbox_credentials <- dropbox_auth("my_consumer_key","my_consumer_secret")` <br>

 If you entered valid keys, you will be directed to a secure page on Dropbox asking you to authorize this app. Click authorize to add this to your approved app list and to return to R.

 There is no need to run `dropbox_auth()` for each subsequent run. Simply save your credentials file to disk and load as needed:

 `save(dropbox_credentials,file="my_dropbox_credentials.rdata")`

 Credentials will remain valid until you revoke them from your [Dropbox Apps page](https://www2.dropbox.com/developers/apps) by clicking the x on the right of your app.


### Quick Guide
This package essentially provides standard Dropbox file operation functions (create/copy/move/restore/share) from within `R`. For a vignette, type: <br>

`vignette('rdrop')` from the `R` prompt.
<br><em>Not yet setup</em>

To load a previously validated Dropbox credential file: <br>

`load('/path/to/my_dropbox_credentials.rdata')`

**Summary of your Dropbox Account**

`dropbox_acc_info(my_dropbox_cred)` # Returns a list with your display name, email, quota, referral URL and country.

**Directory listing**

`dropbox_dir(cred)` # will list contents of your Dropbox root. <br>
`dropbox_dir(cred,path)` # will return dir listing of specified path. <br>

**Download files from your Dropbox account to R**

**Upload R objects to your Dropbox**

**Moving files within Dropobx**

**Copying files within Dropbox**

**Creating a public share for any Dropbox file or folder**


**For more information on usage and tips, see:** <br>
*	[Introducing a programmatic interface to Dropbox from R](http://link_goes_nowhere) <br>
*	 [rDrop on CRAN](http://link goes nowhere) <br>

