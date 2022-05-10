describe("Home Page", () => {

  beforeEach(() => {
    cy.visit('http://localhost:3000/');
  });

  it("This is the home page", () => {
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 12 products on the page", () => {
    cy.get(".products article").should("have.length", 12);
  });

});