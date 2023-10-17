enum Environment {
  dev,
  stage,
  prelive,
  live,
}

enum ToastState {
  info,
  success,
  warning,
  error,
}

enum VerticalSwipeAxis {
  top,
  bottom,
}

enum RegistrationSteps {
  companyIntroduction, //  company-introduction
  managementIntroduction, //  management-introduction
  documentsUpload, //  documents-upload
  suggestedCompany, //  suggested-company
  contactInfo, //  contact-info
  suggestedBranch, // suggested-branch
  finalize, // finalize-info
}

enum CDNRequestType {
  scfRegistrationActivityArea, //  SCF-REGISTRATION-ACTIVITY-AREA
  scfRegistrationActivityType, //  SCF-REGISTRATION-ACTIVITY-TYPE
}

enum ButtonType {
  fill,
  outline,
  text,
  textAndIcon,
}

enum Position {
  ceo, //  CEO
  member, //  MEMBER
}

enum OTPStep {
  phoneNumber,
  otp,
}

enum TargetPlatformType {
  androidNative, // ANDROID_NATIVE
  androidPwa, // ANDROID_PWA
  iosNative, // IOS_NATIVE
  iosPwa, // IOS_PWA
  other, // OTHER
}
