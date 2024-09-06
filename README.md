# Microsoft UET Consent Mode Tag for GTM

**Set or update Microsoft UET Consent Mode Settings (Custom Tag Template for Google Tag Manager)**

    
[![Template Status](https://img.shields.io/badge/Community%20Template%20Gallery%20Status-published-green)](https://tagmanager.google.com/gallery/#/owners/mbaersch/templates/microsoft-consent-mode-tag) ![Repo Size](https://img.shields.io/github/repo-size/mbaersch/microsoft-consent-mode-tag) ![License](https://img.shields.io/github/license/mbaersch/microsoft-consent-mode-tag)

---

## Usage
Install the tag template and add a new *Microsoft UET Consent Mode* tag. Pick "default" or "update" as type of push you want to execute and pick either *denied* or *granted* (or use a variable that holds one of those values) for the `ad_storage` setting. When fired, the tag pushes the configured setting to the `uetq` queue of the UET tag that then can pick up that setting and add a signal to all outgoing requests.

### Setting status with a variable
When using a variable to set status to *granted* or *denied*, either *granted* or *true* will result in *granted* as value. All other variable values including `undefined` will set the status to *denied*. 

### Wait for update
Even if this option is not documented [in this help article about UET consent mode](https://help.ads.microsoft.com/apex/index/3/en/60119), it seems to work just like expected from using Google Consent Mode. 

### Enable TCF
If you use a TCF v2.0 compatible consent platform on you website and want to instruct UET to respect settings from the TCF v2.0 string, check this option. More about this integration and how UET handles purpose settings can be found [in this help article](https://help.ads.microsoft.com/?ocid=#apex/ads/en/60186/2). 

### Set Clarity cookie consent
Microsoft Clarity can be set up to run without cookies until consent was given ([Clarity help](https://learn.microsoft.com/en-us/clarity/setup-and-installation/cookie-consent)). The tag can use the *ad_storage status* setting and instruct Clarity to either enable or deactivate (delete existing) Clarity cookies. If this option is checked, a value of *denied* for *ad_storage status* will call `window.clarity('consent', false)`, *granted* calls `window.clarity('consent')` after UET consent was set accordingly.     

### Push event
The tag can push an event to the dataLayer when a consent command was sent. The event name will be `uet_consent_default` or `uet_consent_update`. Both dataLayer events contain a key `uet_consent_settings` with the configuration array that was sent with the UET consent command.   

### Check if it works
After installing ad configuring, fire this tag and a UET tag (you can use the  Consent Mode tag as set-up tag for the UET using tag sequencing) and watch for a `asc` parameter (either using the network tab of your browser´s developer tools or by inspecting the parameters with the UET Tag Helper extension in Chrome). If consent was granted, the value should be *G*, otherwise *D*. If you do not find the `asc` parameter, something is wrong. Check the order in which tags are fired and make sure, that the *Microsoft UET Consent Mode" tag fires directly before or after the UET tag. 
