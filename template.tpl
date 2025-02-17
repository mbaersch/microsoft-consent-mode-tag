﻿___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Microsoft UET Consent Mode",
  "categories": [
    "UTILITY"
  ],
  "brand": {
    "id": "mbaersch",
    "displayName": "",
    "thumbnail": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAB9ElEQVR42mP8//8/Ay0BE01NH7WABAvev/9JIwtYINTMmTclJbni41XgEgsX3jl9+s2UKRZA9rZtT7q7ryBrmzrVYtq0G1evfkAzLiFBBdkQhAWPH3/7+fMfssSDB1/g+oE2vX79c+pUc7isqCiHqakIkASyFyy4o6DA4+AgAWQDGdh9QBCIirLb20sgi8BdeuDAC6Dp9fUG+OKAdoBYHwBDrLHxAoQNdC+ab/CAQeMDYOzhCmWifMDBwQwMBLQw4eYm1nrCFtjbi2/b9vTaNWi6BDKA3NBQBfIMXbFiRXV1NUoQ+fnJtbZe1tbe6OAgzgBKeS9DQ+WRs8y1ax8dHXfAucCMpqUlgGn027dvo6OjgYylS5dCRBiR6wNgjgXmKSAD6HZk/a9f/4B7DgKAspBcBvEuMDDl5XkuXrwYHBzs5uY2bdo0hNL/VAJbt24VFBTMzMxEE6eOBcuXLwe61cTE5M2bN9S3AGK6srIypulUsODCBVD2BgYOkIFVAUUWAA0FGg20AOgJXGpIsGDGjBlA4+ABDSSBbKDp4eHheHQRawHQOGAKgSQ8SFKpqqrCE/RkBhHQsRA7IBELBMDUiV8LaRbcvXsXObu5u7sT1EJyJMMDCgiA9lHfArgngHFOjHpykinQE7hSPSZAKexoAYZ+0xEA/YWJATjOiCUAAAAASUVORK5CYII\u003d"
  },
  "description": "",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "cmType",
    "displayName": "Consent command",
    "macrosInSelect": true,
    "selectItems": [
      {
        "value": "default",
        "displayValue": "default"
      },
      {
        "value": "update",
        "displayValue": "update"
      }
    ],
    "simpleValueType": true,
    "defaultValue": "default",
    "alwaysInSummary": true,
    "help": "Define the type of \"consent\" command to use. Find details about UET consent mode here: https://help.ads.microsoft.com/apex/index/3/en/60119"
  },
  {
    "type": "TEXT",
    "name": "waitForUpdate",
    "displayName": "Wait for Update",
    "simpleValueType": true,
    "defaultValue": 0,
    "valueValidators": [
      {
        "type": "NON_NEGATIVE_NUMBER"
      }
    ],
    "enablingConditions": [
      {
        "paramName": "cmType",
        "paramValue": "default",
        "type": "EQUALS"
      }
    ],
    "help": "Optionally define a timespan in milliseconds how long UET tags should wait for an \"Update\" command."
  },
  {
    "type": "SELECT",
    "name": "cmState",
    "displayName": "ad_storage status",
    "macrosInSelect": true,
    "selectItems": [
      {
        "value": "granted",
        "displayValue": "granted"
      },
      {
        "value": "denied",
        "displayValue": "denied"
      }
    ],
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "alwaysInSummary": true,
    "help": "If you use a variable to set the value, make sure to use \"granted\" or \"true\" as value (case-insensitive) for \"granted\" status. Everything else will result in \"denied\""
  },
  {
    "type": "CHECKBOX",
    "name": "enableTcf",
    "checkboxText": "Enable TCF",
    "simpleValueType": true,
    "alwaysInSummary": true,
    "help": "Check this option to configure UET to use the TCF v2.0 string to control tag behaviour. For details see https://help.ads.microsoft.com/?ocid\u003d#apex/ads/en/60186/2"
  },
  {
    "type": "CHECKBOX",
    "name": "cnfClarity",
    "checkboxText": "Set Clarity cookie consent",
    "simpleValueType": true,
    "alwaysInSummary": true,
    "help": "Check to instruct Clarity to use cookies if status is set to \"granted\" or erase cookies otherwise"
  },
  {
    "type": "CHECKBOX",
    "name": "pushEvent",
    "checkboxText": "Push event to dataLayer when done",
    "simpleValueType": true,
    "alwaysInSummary": true,
    "help": "Check this to receive a dataLayer event when consent command got sent to UET. The event name will be \"uet_consent_default\" or \"uet_consent_update\". The key \"uet_consent_settings\" will contain UET settings that were set with that command."
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const createQueue = require('createQueue');
const uetq = createQueue('uetq');

let cmVal = require('makeString')(data.cmState||"denied").toLowerCase(), 
    cmStatus = (cmVal == "granted" || cmVal == "true") ? "granted" : "denied";

let cmSettings = {'ad_storage': cmStatus};
if (data.cmType === 'default' && data.waitForUpdate > 0)
  cmSettings.wait_for_update = require('makeNumber')(data.waitForUpdate);
uetq('consent', data.cmType||'default', cmSettings);

if (data.enableTcf === true) 
  uetq('config', 'tcf', { 'enabled' : true });

if (data.pushEvent) 
  createQueue('dataLayer')({
    'event': 'uet_consent_' + data.cmType,
    'uet_consent_settings' : cmSettings
  }); 

if (data.cnfClarity === true) {
  const callInWindow = require('callInWindow');
  if (cmStatus === 'granted') 
    callInWindow('clarity', 'consent');
  else 
    callInWindow('clarity', 'consent', false);
}

data.gtmOnSuccess();


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "uetq"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "dataLayer"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "clarity"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 18.7.2024, 17:24:15


