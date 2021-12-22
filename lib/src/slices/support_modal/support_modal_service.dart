/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';

import '../api_zendesk/api_zendesk_service.dart';
import '../api_zendesk/model/api_zendesk_article.dart';
import '../api_zendesk/model/api_zendesk_category.dart';
import '../api_zendesk/model/api_zendesk_section.dart';
import 'support_modal_controller.dart';
import 'support_modal_presenter.dart';

class SupportModalService extends ChangeNotifier {
  late final SupportModalPresenter presenter;
  late final SupportModalController controller;
  final ApiZendeskService zendeskService = ApiZendeskService();

  dynamic data;

  SupportModalService() {
    this.presenter = SupportModalPresenter(this);
    this.controller = SupportModalController(this);
    getCategories();
  }

  Future<void> getCategories() async {
    this.data =
        await zendeskService.getZendeskCategories(includeSections: true);
    notifyListeners();
  }

  Future<void> getSectionsForCategory(ApiZendeskCategory category) async {
    this.data = await zendeskService.getZendeskSections(category.id,
        includeArticles: true);
    notifyListeners();
  }

  Future<void> getArticlesForSection(ApiZendeskSection section) async {
    this.data = await zendeskService.getZendeskArticles(section.id);
    notifyListeners();
  }

  Future<void> getArticleById(ApiZendeskArticle article) async {
    this.data = await zendeskService.getZendeskArticle(article.id);
    notifyListeners();
  }

  var mockCats = [
    ApiZendeskCategory.fromMap({
      'id': 1,
      'title': 'Getting started',
      'description':
          'Here’s all you need to know about getting started with TIKI!',
      'sections': [
        ApiZendeskSection.fromMap({
          'id': 2,
          'title': 'Section 1',
          'description': 'Lorem Ipsum dolor set Amet.',
        }),
        ApiZendeskSection.fromMap({
          'id': 3,
          'title': 'Section 2',
          'description': 'Section 2 description lorem ipsum dolor',
        }),
        ApiZendeskSection.fromMap({
          'id': 4,
          'title': 'Section 4',
          'description': 'The last section for the category test',
          'sections': []
        })
      ]
    }),
    ApiZendeskCategory.fromMap({
      'id': 1,
      'title': 'Getting started',
      'description':
          'Here’s all you need to know about getting started with TIKI!',
      'sections': [
        ApiZendeskSection.fromMap({
          'id': 3,
          'title': 'Section 2',
          'description': 'Section 2 description lorem ipsum dolor',
        }),
        ApiZendeskSection.fromMap({
          'id': 4,
          'title': 'Section 4',
          'description': 'The last section for the category test',
          'sections': []
        })
      ]
    }),
    ApiZendeskCategory.fromMap({
      'id': 2,
      'title': 'Referrals',
      'description': 'How to invite people to earn money for your ...',
      'sections': [
        ApiZendeskSection.fromMap({
          'id': 2,
          'title': 'Section 1',
          'description': 'Lorem Ipsum dolor set Amet.',
        }),
        ApiZendeskSection.fromMap({
          'id': 3,
          'title': 'Section 2',
          'description': 'Section 2 description lorem ipsum dolor',
        }),
        ApiZendeskSection.fromMap({
          'id': 4,
          'title': 'Section 4',
          'description': 'The last section for the category test',
          'sections': []
        }),
        ApiZendeskSection.fromMap({
          'id': 2,
          'title': 'Section 1',
          'description': 'Lorem Ipsum dolor set Amet.',
        }),
        ApiZendeskSection.fromMap({
          'id': 3,
          'title': 'Section 2',
          'description': 'Section 2 description lorem ipsum dolor',
        }),
        ApiZendeskSection.fromMap({
          'id': 4,
          'title': 'Section 4',
          'description': 'The last section for the category test',
          'sections': []
        })
      ]
    }),
    ApiZendeskCategory.fromMap({
      'id': 3,
      'title': 'Monetization',
      'description':
          'Find out when these features are becoming available, and what our plan is.',
      'sections': [
        ApiZendeskSection.fromMap({
          'id': 4,
          'title': 'Section 4',
          'description': 'The last section for the category test',
          'sections': []
        })
      ]
    }),
    ApiZendeskCategory.fromMap({
      'id': 4,
      'title': 'Product roadmap',
      'description':
          'Find out what we’re releasing next and how to feedback or request a new feature.',
      'sections': [
        ApiZendeskSection.fromMap({
          'id': 2,
          'title': 'Section 1',
          'description': 'Lorem Ipsum dolor set Amet.',
        }),
        ApiZendeskSection.fromMap({
          'id': 3,
          'title': 'Section 2',
          'description': 'Section 2 description lorem ipsum dolor',
        }),
        ApiZendeskSection.fromMap({
          'id': 4,
          'title': 'Section 4',
          'description': 'The last section for the category test',
          'sections': []
        }),
        ApiZendeskSection.fromMap({
          'id': 2,
          'title': 'Section 1',
          'description': 'Lorem Ipsum dolor set Amet.',
        }),
        ApiZendeskSection.fromMap({
          'id': 3,
          'title': 'Section 2',
          'description': 'Section 2 description lorem ipsum dolor',
        }),
        ApiZendeskSection.fromMap({
          'id': 4,
          'title': 'Section 4',
          'description': 'The last section for the category test',
          'sections': []
        })
      ]
    }),
    ApiZendeskCategory.fromMap({
      'id': 5,
      'title': 'About TIKI',
      'description':
          'All you need to know about TIKI’s vision, team and future plans.',
      'sections': [
        ApiZendeskSection.fromMap({
          'id': 2,
          'title': 'Section 1',
          'description': 'Lorem Ipsum dolor set Amet.',
        }),
        ApiZendeskSection.fromMap({
          'id': 3,
          'title': 'Section 2',
          'description': 'Section 2 description lorem ipsum dolor',
        }),
        ApiZendeskSection.fromMap({
          'id': 4,
          'title': 'Section 4',
          'description': 'The last section for the category test',
          'sections': []
        }),
        ApiZendeskSection.fromMap({
          'id': 2,
          'title': 'Section 1',
          'description': 'Lorem Ipsum dolor set Amet.',
        }),
        ApiZendeskSection.fromMap({
          'id': 3,
          'title': 'Section 2',
          'description': 'Section 2 description lorem ipsum dolor',
        }),
        ApiZendeskSection.fromMap({
          'id': 4,
          'title': 'Section 4',
          'description': 'The last section for the category test',
          'sections': []
        })
      ]
    })
  ];

  var mockSections = [
    ApiZendeskSection.fromMap({
      'id': 2,
      'title': 'Section 1',
      'description': 'Lorem Ipsum dolor set Amet.',
    }),
    ApiZendeskSection.fromMap({
      'id': 3,
      'title': 'Section 2',
      'description': 'Section 2 description lorem ipsum dolor',
    }),
    ApiZendeskSection.fromMap({
      'id': 4,
      'title': 'Section 4',
      'description': 'The last section for the category test',
    })
  ];
}
