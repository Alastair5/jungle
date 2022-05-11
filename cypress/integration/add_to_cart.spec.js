describe('Homepage test', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000/');
  });

  it('should display the homepage', () => {
  });

  it("should click on the add to cart button and increase cart by one", () => {
    cy.get('.end-0 > .nav-link').contains(0);
    cy.get(':nth-child(1) > div > .button_to > .btn').click({force: true});
    cy.get('.end-0 > .nav-link').contains(1);
  });

});