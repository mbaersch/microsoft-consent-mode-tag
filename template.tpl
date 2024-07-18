___TERMS_OF_SERVICE___

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
    "thumbnail": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADC0lEQVR42mP8dWD932unGYgCjGwhWS/ZX555MoM49QxKQs4sQNN/71pBnPmMrO6RH/49OPt0FpEWsDJzMxGplGxAcwtY4CzO5qXfa6PhXPbUht/bl/x7cgfIYJJThTpHUoH/14944/3IRlx4tuDi84WELWDRsUDxmpwqI78QwxMQ48/Rbf8e3wZGAntW61fW10cedgAVJJocmH/GAcj48P0BUT7AA4Cm/716ChjJDD++/WH+/vD9QYg4nEGpBUyykCBiZGBhJT8O8ABWz5j/n96BbODgZvhPAwt+zqqHBBFXz0YGbtIsQCTTf6+eMKnoQtiMfEJMMipAEVIDBJ8Pfi7s4Kye82f/uv8/v7M6Bf85tv3/62fQIHIKZganMUYBUYbft8i0AGji39sXWZ1CgOzv3Tn/7lyGiP/et5ZJTAZT5/67DaRZAARAJ/9aOQlNBdBPUBYjI4uZCzwODt5rJMYCkooKRpICB6rn76sn/z+9J1I1k4zyD6Yf77/fI1I9N5sYy2MuyTdM4kRq0GRm5vr/g5MUH7C0Xfkx684vopzPwHDGk8fw9wGGi0HEGi9XSGpxTXI0DJoKx0uKZZMDtwovEwOPNgOHPEjIZD+D3ip0dRpTGAy3kGzBFBPOLkPO6bd+vvj+j+H/Xwa1bpCokAMDvykDnylCHdBiUW8QIskCeW7GUHlWxz1ftj/78+UPA8PXGwyXwqByj6YyyGYhlCo3MGBkb8IWhMqxLbz36/VPbMX0s4UM0gnQEGMVBXno9TaSLeBmYfj6B0cl8Ps1w9MFDFIJILZUPMPH0yARUi34+odBAU/r5kE3yBNAIJfNgK34I2zB6ke/vKRZgTGBEAKGBsL+awx/v4KS069XDD8ekmPBw6//c05/P+XB22HIIcHByCBkz6AzH90TEqEMj6dh1U5UMl396LfZjs/fIDHx5QbDeR8Q4w4sQIARC2Q/gzWN4OLEWwDxR9Plny9+/Gf49RIqBK8PgBGLXDeg1hO0bzoGybKCCgAiADCWpbgYGf5qM6h1EWs8nzEA48MRtfTMbBAAAAAASUVORK5CYII\u003d"
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
    "displayName": "Consent Mode Settings Type",
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
    "alwaysInSummary": false
  },
  {
    "type": "SELECT",
    "name": "cmState",
    "displayName": "Ad Storage Status",
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
    "alwaysInSummary": false
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

require('createQueue')('uetq')('consent', data.cmType||'default', {'ad_storage': data.cmState||'denied'});
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


