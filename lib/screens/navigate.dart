import 'package:flutter/material.dart';

import './auth/login_page.dart';
import './search/search_page.dart';
import './auth/admin_page.dart';

import './store/stores_page.dart';
import './store/store_menu_page.dart';
import './store/new_store_page.dart';
import './store/update_store_page.dart';

import './store/menu/menu_page.dart';
import './store/menu/new_menu_page.dart';
import './store/menu/update_menu_page.dart';

navigateToSearchPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return SearchPage();
  }));
}

navigateToLoginPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return LoginPage();
  }));
}

navigateToAdminPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return AdminPage();
  }));
}

navigateToUpdateStorePage(
    BuildContext context, String docID, String storeName) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return UpdateStore(docID: docID, storeName: storeName);
  }));
}

navigateToNewStorePage(
  BuildContext context,
) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return NewStore();
  }));
}

navigateToAdminMenuPage(BuildContext context, String docID, String storeName) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return MenuPage(docID: docID, storeName: storeName);
  }));
}

navigateToMenuPage(BuildContext context, String docID, String storeName) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return StoreMenuPage(docID: docID, storeName: storeName);
  }));
}

navigateToNewMenuPage(BuildContext context, String docID) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return NewMenu(docID: docID);
  }));
}

navigateToUpdateMenuPage(BuildContext context, String docID, String name) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return UpdateMenu(docID: docID, name: name);
  }));
}

navigateToStoresPage(BuildContext context, String category) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return StoresPage(category: category);
  }));
}
