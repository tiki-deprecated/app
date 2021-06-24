var slides = [
  {
  "coverData": {
    'topHeader': {
      'image' : "gmail-round-logo",
      'title' : "Your Gmail account",
      'sharecard' : {
        "message": "Gmail knows where you are when you read your emails. It's your data, start taking it back on https://www.mytiki.com",
        "image": 'socialmedia1.png'
        }
      },
    'image': "where-you-are",
    'subtitle': "Gmail knows...",
    'bigTextLighter': 'Where you are ',
    'bigTextDarker': 'when you read your emails.',
    'subText':
    "Your Gmail account tracks your location when you open your emails...\nEvery single time you do it."
  },
  "cardData": {
    'cardContentData': {
      'richTextExplanation': [
        {'text' : "Gmail records your ",
        'url' : null,
        },
        {'text' : "IP address",
        'url' : "https://en.wikipedia.org/wiki/IP_address",
        },
        {'text' : " every time you open your inbox or send an email.\n\nMost Google products and almost all email services do this. Some, like Outlook, but NOT Gmail, will even send your IP address to the person receiving your email.\n\nThe most common use approximates your location, pinpointing you within 3-5 miles anywhere in the world. In extreme cases, like criminal investigations, your IP address can be tied to your exact device and location by working with an Internet Service Provider.",
        'url' : null,
        }
      ],
      'theysay': [
          {
          'image': "info-badge",
          'text': "Security monitoring to suspicious access"
          },
          {
        'image': "search-graph",
        'text': "Analyzing patterns to develop new features and products"
        },
      ],
      'youShouldKnow': [
        {
        'image': "np-tap",
        'text':
        "Used advertisers for location-based targeting and surveillance"
        },
        {
          'image': "badge", 'text': "Used by law enforcement"},
        {
          'image': "worldwide",
          'text': "Saved for 9 months, then obscured and kept permanently"
        }
      ]
    },
    'cardCtaData': {
      'richTextExplanation': [
        {'text' : "You can use a ",
        'url' : null,
        },
        {'text' : "VPN",
        'url' : 'https://nordvpn.com',
        },
        {'text' : " to hide your IP address or, for true anonymity, switch to an ",
        'url' : null,
        },
        {'text' : "encrypted email service",
        'url' : 'https://protonmail.com',
        },
        {'text' : ".\n\nGmail does not currently use additional location services.\n\nIf you just hate the ads, you can turn off ad personalization for your entire Google account. ",
        'url' : null,
        },
      ],
      'buttonText': "AD PERSONALIZATION",
      'btnActionUrl': "https://adssettings.google.com"
      }
    }
  },
  {
    "coverData": {
      'topHeader': {
        "image" : "gmail-round-logo",
        "title" : "Your Gmail account",
        "shareCard" : {
          "message": "Gmail knows what you've written to your friends. Find out more on https://www.mytiki.com",
          "image": 'socialmedia2.png'
        },
        'image': "what-written",
        'subtitle': "Gmail knows...",
        'bigTextLighter': 'What you’ve written to ',
        'bigTextDarker': 'your friends',
        'subText': "Gmail has all emails you’ve ever written to anyone. They look at the content in the emails, so they know you better."
      },
    },
    'cardData': {
      'cardContentData': {
        'richTextExplanation': [
          {
            'text' : "Gmail has access to your emails - it reads, stores and analyzes them.\n\nGoogle uses this information for targeted ads and what they call “smart features” like automatically adding your flight information to your calendar.\n\nIn their own words:\n\n\nCreepy.",
            'url' : null,
          }
        ],
        'theysay': [
          {
          'image': "airplane",
          'text': "Travel assistance like itineraries, updates, and maps."
          },
          {
          'image': "email",
          'text':
          "Smart email with suggestions, nudges, prioritization, and filtering"
          },
          {
          'image': "package",
          'text': "Track packages, reservations, loyalty cards, and bills"
          },
        ],
        'youShouldKnow': [
          {
          'image': "np-tap",
          'text': "Used by advertisers for key word targetting"
          },
          {'image': "hammer", 'text': "Used by law enforcement"},
          {'image': "worldwide", 'text': "Disabled by default in Europe"}
        ]
      },
      'cardCtaData': {
        'richTextExplanation': [
          {
            'text': "You can turn off both,",
            'url' : null
          },
          {"url" : "https://support.google.com/mail/answer/10079371",
          "text" : " ad personalization "
          },
          {"text" : "and “smart features” to stop Google from scanning your emails.", "url" : null}
        ],
        'buttonText': "STOP READING MY EMAILS",
        'btnActionUrl': () =>
        "https://support.google.com/mail/answer/10079371"
        }
    }
  },
  {
  "coverData": {
    'topHeader': {
      "image": "gmail-round-logo",
      "text": "Your Gmail account",
      "shareCard": {
        "message": "Gmail knows what you've written to your friends. Find out more on https://www.mytiki.com",
        "image": 'socialmedia2.png',
      },
    },
    'image': "everything-you-do",
    'subtitle': "Gmail knows...",
    'bigTextLighter': "Everything\n",
    'bigTextDarker': 'you do in your Gmail app',
    'subText':
    "Your Gmail app has quite a lot of analytics packed in and knows quite a few things...."
  },
  "cardData": {
    'cardContentData': {
      'richTextExplanation': [
        {
          "url" : null,
          "text" : "Gmail’s app is designed to track most of the things you do with it. It tracks each action you take, on which device, OS, and time of day.\n\nFor example, when you opened the app, what you searched for and if you saw an ad were all tracked.\n\nYour audio is recorded if you use voice search or assistant with Gmail.",
        }
      ],
      'theysay': [
        {'image': "person-4", 'text': "Personalized experiences"},
        {
          'image': "circle-badge",
          'text': "App and content recommendations"
        },
        {'image': "search", 'text': "Faster Search"},
      ],
      'youShouldKnow': [
        {
        'image': "hat-n-glasses",
        'text': "Your activity is tracked even when logged out"
        },
        {'image': "badge", 'text': "Used by law enforcement"},
        {
        'image': "bomb",
        'text':
        "You can set your history to auto delete after 3, 18, or 36 months"
        }
      ]
    },
    'cardCtaData': {
      'richTextExplanation': [ {
        'text': "You can delete all activities, individual activities, set it to auto-delete, or disable activity tracking entirely.",
        'url' : null
      }],
      'buttonText': "MY ACTIVITY",
      'btnActionUrl': () => "https://myactivity.google.com"
    }
  }
  }
];


