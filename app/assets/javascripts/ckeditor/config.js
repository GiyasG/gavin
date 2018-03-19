CKEDITOR.editorConfig = function (config) {
  // ... other configuration ...

  // config.toolbar_mini = [
  //   ["Bold",  "Italic",  "Underline",  "Strike",  "-",  "Subscript",  "Superscript"],
  // ];
  // config.toolbar = "mini";

  // ... rest of the original config.js  ...
  config.enterMode = CKEDITOR.ENTER_BR;
  config.autoParagraph = false;
}
