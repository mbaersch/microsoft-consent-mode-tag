# Microsoft UET Consent Mode Tag for GTM

**Set or update Microsoft UET Consent Mode Settings (Custom Tag Template for Google Tag Manager)**

[![Template Status](https://img.shields.io/badge/Community%20Template%20Gallery%20Status-submitted-orange)](https://tagmanager.google.com/gallery/#/owners/mbaersch/templates/microsoft-consent-mode-tag) ![Repo Size](https://img.shields.io/github/repo-size/mbaersch/microsoft-consent-mode-tag) ![License](https://img.shields.io/github/license/mbaersch/microsoft-consent-mode-tag)
    
---

## Usage
Install the tag template and add a new *Microsoft UET Consent Mode* tag. Pick "default" or "update" as type of push you want to execute and pick either *denied* or *granted* (or use a variable that holds one of those values) for the `ad_storage` setting. When fired, the tag pushes the configured setting to the `uetq` queue of the UET tag that then can pick up that setting and add a signal to all outgoing requests. 

Find more information about setting up UET for consent mode [in this help article](https://help.ads.microsoft.com/apex/index/3/en/60119).

### Check if it works
After installing ad configuring, fire this tag and a UET tag (you can use the  Consent Mode tag as set-up tag for the UET using tag sequencing) and watch for a `asc` parameter (either using the network tab of your browser´s developer tools or by inspecting the parameters with the UET Tag Helper extension in Chrome). If consent was granted, the value should be *G*, otherwise *D*. If you do not find the `asc` parameter, something is wrong. Check the order in which tags are fired and make sure, that the *Microsoft UET Consent Mode" tag fires directly before or after the UET tag. 
