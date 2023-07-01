part of essential;

class DashboardController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String uid = "";
  String token = "";
  String username = "";
  String contentHeader = "";
  String fullname = "";
  String userLevel = "";

  List<String> subUrlList = [
    "dashboard",
    "manage-stock",
    "category",
    "location"
  ];
  String subUrl = "";

  bool isLoading = false;
  bool isRightSidebarLoading = false;
  bool responsiveMobile = false;
  bool responsiveTablet = false;
  bool responsiveDesktop = false;

  LocalStorageServices localStorageServices = LocalStorageServices();

  Widget rightSidebarData = const Text("Not found!");

  Widget contentData = LoadingWidget();

  Future<void> initGet() async {
    token = localStorageServices.readData("token");
    fullname =
        "${localStorageServices.readData("firstname")} ${localStorageServices.readData("lastname")}";
    uid = localStorageServices.readData("uid");
    userLevel = localStorageServices.readData("userlevel");
    print(href);
    if (subUrl.isEmpty && subUrl == "") {
      //Web Build Only
      if (kIsWeb) {
        subUrl = href!.split("/")[3];
        print("SUBURL ---- $subUrl");
        setUrl();
      } else {
        subUrl = "dashboard";
      }
    } else {
      setUrl();
      closeDrawer();
    }

    //fetchContentData();
  }

  //ContentData
  Future<void> fetchContentData() async {
    isLoading = true;
    await Future(
      () => contentData,
    );
    //await Future.delayed(const Duration(milliseconds: 500), () => contentData);
    isLoading = false;
    update();
  }

  //SetUrl
  void setUrl() {
    //WebBuildOnly
    if (kIsWeb) {
      log("SetUrl Void Data $subUrl");
      html.window.history.pushState(null, "", "home/$subUrl");
      print(href!);
    }
    fetchContentData();
    setHeader();
  }

  //Set Header
  void setHeader() {
    switch (subUrl) {
      case "dashboard":
        print(subUrl);
        contentHeader = "Dashboard Page";
        break;
      case "manage-stock":
        print(subUrl);
        contentHeader = "Manage Stock Page";
        break;
      case "category":
        contentHeader = "Category Page";
        break;
      case "location":
        contentHeader = "Location Page";
        //fetchProductImage();
        break;
      default:
    }
  }

  //Init Selected DrawerMenuItem
  int initSelected() {
    print("initSelected $subUrl");
    switch (subUrl) {
      case "dashboard":
        return 0;
      case "manage-stock":
        return 1;
      case "category":
        return 2;
      case "location":
        return 3;
      default:
        return 0;
    }
  }

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  void openEndDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openEndDrawer();
    }
  }

  void closeDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.closeDrawer();
    }
  }

  void closeEndDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.closeEndDrawer();
    }
  }

  //Main Page State Controller
  Stream<Widget> mainPageStateController(
    BuildContext context,
    DashboardController controller,
    BoxConstraints constraints,
  ) async* {
    Dashboard dashboard = Dashboard();
    ManageStock manageStock = ManageStock();
    switch (controller.subUrl) {
      case 'dashboard':
        contentData =
            dashboard.dashboardContent(context, constraints, controller);
        // rightSidebarData = DashboardRightContent(controller: controller);
        break;
      case 'manage-stock':
        contentData = manageStock.content(context, controller);
        break;
      case 'orders':
        contentData =
            dashboard.dashboardContent(context, constraints, controller);
        break;
      case 'products':
        contentData =
            dashboard.dashboardContent(context, constraints, controller);
        //contentData = product.ProductContent(context, constraints, controller);
        //rightSidebarData = ProductRightContent(controller: controller);
        break;
      case 'profile':
        contentData =
            dashboard.dashboardContent(context, constraints, controller);
        break;
      case 'settings':
        contentData =
            dashboard.dashboardContent(context, constraints, controller);
        break;
      default:
    }
    yield contentData;
    //yield rightSidebarData;
  }

  ProjectCardData getSelectedUser() {
    return ProjectCardData(
      percent: .3,
      projectImage: const AssetImage(ImageData.logo),
      projectName: fullname,
      subtitleText: userLevel.toString(),
      customerCount: 1,
      releaseTime: DateTime.now(),
    );
  }

  // Data
  Profile getProfile() {
    return Profile(
      photo: AssetImage(ImageData.user),
      name: username,
      email: token,
    );
  }
}
