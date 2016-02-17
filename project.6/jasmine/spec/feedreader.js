/* feedreader.js
 *
 * This is the spec file that Jasmine will read and contains
 * all of the tests that will be run against your application.
 */
/* We're placing all of our tests within the $() function,
 * since some of these tests may require DOM elements. We want
 * to ensure they don't run until the DOM is ready.
 */
$(function() {
    /* This is our first test suite - a test suite just contains
     * a related set of tests. This suite is all about the RSS
     * feeds definitions, the allFeeds variable in our application.
     */
    describe('RSS Feeds', function() {
        /* This is our first test - it tests to make sure that the
         * allFeeds variable has been defined and that it is not
         * empty. Experiment with this before you get started on
         * the rest of this project. What happens when you change
         * allFeeds in app.js to be an empty array and refresh the
         * page?
         */
        it('allFeeds are defined', function() {
            expect(allFeeds).toBeDefined();
            expect(allFeeds.length).not.toBe(0);
        });

        it('feed URl and name are defined', function() {
            for (var i = 0; i < allFeeds.length; i++) {
                /* in the allFeeds object and ensures it has a URL defined */
                expect(allFeeds[i].url).not.toBeUndefined();

                /* and that the URL is not empty. */
                expect((allFeeds[i].url).length).toBeGreaterThan(0);

                /* in the allFeeds object and ensures it has a name defined */
                expect(allFeeds[i].name).not.toBeUndefined();

                /* and that the name is not empty. */
                expect((allFeeds[i].name).length).not.toBeLessThan(1);
            }
        });
    });


    /* Write a new test suite named "The menu" */
    describe('The menu', function() {
        /* check body's call name for hiding the menu by default */
   
        it('menu element is hidden by default', function() {
            expect($('body').hasClass('menu-hidden')).toBe(true);
        });
        
        /* trigger the menu click event 
           and check the menu's visibility
        */

        it('menu element change visibility', function() {

            $('.menu-icon-link').trigger('click');
            //expect($('body').hasClass('')).toBe(true);
            expect($('body').hasClass('menu-hidden')).toBeFalsy();
            
            $('.menu-icon-link').trigger('click');
            //expect($('body').attr('class')).toEqual('menu-hidden');
            expect($('body').hasClass('menu-hidden')).toBe(true);
        });
    });
    
    /* Write a new test suite named "Initial Entries" */
    describe('Initial Entries', function() {
        /* call the loadFeed async function and check the feedback entry at least one */
        
        beforeEach(function(done) {
            loadFeed(0, done);
        });
        it('entry should greater than 0', function() {
            expect($('.entry-link').length).toBeGreaterThan(0);
        });
    });
    
    /* Write a new test suite named "New Feed Selection" */
    describe('New Feed Selection', function() {
        /* call loadFeed two times and compare the two results  */

        /* i use  JQuery text() to pull all contents of the entries of each feed together for comparision         */
        /* i think this comparison is much better than just comparing the length of each feed                     */
        var entry1, entry2;
        beforeEach(function(done) {
            loadFeed(1, function(){
                 //console.log($('.entry h2').text());
                 entry1 = $('.entry h2').text();
                 done();
            });
        });    
       beforeEach(function(done) {
            loadFeed(0, function(){
                 //console.log($('.entry h2').text());
                 entry2=$('.entry h2').text();
                 done();
            });
        });

        it('compare old and new feeds', function() {
            //console.log('third');
            expect(entry1).not.toBe(entry2);
            //done();
        }); 
        
    });

}());
