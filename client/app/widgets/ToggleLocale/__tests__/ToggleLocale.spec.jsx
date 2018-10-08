// describe("ToggleLocale", function() {
//   beforeEach(function() {
//     loadFixtures("toggle_locale.html");
//     spyOn($, "ajax").and.callFake(function() {
//        return { done: function() {} };
//      });
//     onReadyToggleLocale();
//   });

//   afterEach(function() {
//     Cookies.remove("locale");
//   });

//   it("calls toggle_locale when value of #locale changes", function() {
//     const $locale = $("#locale");

//     expect($locale.val()).toBe("en");
//     expect(Cookies.get("locale")).toBe(undefined);

//     $locale.val("es").change();

//     expect($locale.val()).toBe("es");
//     expect(Cookies.get("locale")).toBe("es");
//     expect($.ajax).toHaveBeenCalled();
//   });
// });