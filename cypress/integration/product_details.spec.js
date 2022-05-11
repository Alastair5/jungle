describe('Homepage vist test', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000/');
  });
  it('Should display the homepage', () => {

  });
  it("Should click on a product partial and visit product detail page", () => {
    cy.get('[alt="Cliff Collard"]').click();
  });

});