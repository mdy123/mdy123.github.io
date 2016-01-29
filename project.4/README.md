Project 4 - Website Performance Optimization 
============================================

### Modifications for **_index.html_** to get apeed test score 90  
*   convert jpg to webp format. [WebP converter](https://developers.google.com/speed/webp/?hl=en)    
*   inline css into html page.  
*   inline google api font into html page.
*   asynchronously load js file.  

### Modifications for **_pizza.html_**   
*   convert jpg and png to webp format. [WebP converter](https://developers.google.com/speed/webp/?hl=en) 
*   delete all unused css using Audit function of Chrome Dev tool.   
*   inline css into html page.  
*   asynchronously load js file.  
 
###For 60 fps scrolling  
*   ***I use the  img template string (elemTemplate) and replace 'sTop' with top pixiel number,***    
    ***then add it to the black string (elem),***   
    ***and then assign that string (elem) as inner text to the parent node after the loop.***  

``` 
      // Generates the sliding pizzas when the page loads.
      var basicLeft = [];
      var varTop = [];
      document.addEventListener('DOMContentLoaded', function() {
        var cols = 8;
        var s = 256;
        var elemTemplate = '<img class="mover"; src="images/pizza.webp"; style="width:73.33px; height:100px; top:sTop";>';
        var elem = '';
        var pElem = document.querySelector("#movingPizzas1");
        for (var i = 0; i < 100; i++) {
            basicLeft.push((i % cols) * s);
            varTop.push((Math.floor(i / cols) * s) + 'px');
            elem = elem + elemTemplate.replace('sTop', ((Math.floor(i / cols) * s) + 'px'));
        }
        pElem.innerHTML = elem;
        updatePositions(varTop,basicLeft);
      });
```  
 
*   ***I also use the same method using string with different margin left.***    
    ***Then add that string (elem) as innerHTML to the parent node ("#movingPizzas1") after the loop.***  
    
```
      function updatePositions() {
        frame++;
        window.performance.mark("mark_start_frame");
        var elem;
        var phase;
        var scrollTop =(document.body.scrollTop / 1250);
        for (var i = 0; i < varTop.length; i++) {
            phase = Math.sin( scrollTop + (i % 5));
            elem = elem + '<img class="mover" ;="" src="images/pizza.webp" style="width: 73.33px; height: 100px; top:' + varTop[i]; 
            elem = elem + '; left:' + (basicLeft[i] + 100 * phase + 'px') + ';">'
        }
       `document.querySelector("#movingPizzas1").innerHTML = elem;
        // User Timing API to the rescue again. Seriously, it's worth learning.
        // Super easy to create custom metrics.
        window.performance.mark("mark_end_frame");
        window.performance.measure("measure_frame_duration", "mark_start_frame", "mark_end_frame");
        if (frame % 10 === 0) {
        var timesToUpdatePosition = window.performance.getEntriesByName("measure_frame_duration");
        logAverageFrame(timesToUpdatePosition);
      }
```   
*   ***I also use the same method using string to generate different pizza types to increase loding time.***
        
```  
        // This for-loop actually creates and appends all of the pizzas when the page loads
        var htmlStr = '';
        htmlStr = htmlStr + '<div id="pizza0" class="randomPizzaContainer" style="height: 325px;"><div class="col-md-6"><img src="images/pizza.webp" class="img-responsive">
            </div><div class="col-md-6"><h4>The Udacity Special</h4><ul><li>Turkey</li><li>Tofu</li><li>Cauliflower</li><li>Sun Dried Tomatoes</li><li>Velveeta Cheese
            </li><li>Red Sauce</li><li>Whole Wheat Crust</li></ul></div></div> ';
        htmlStr = htmlStr + '<div id="pizza1" class="randomPizzaContainer" style="height: 325px;"><div class="col-md-6"><img src="images/pizza.webp" class="img-responsive">
            </div><div class="col-md-6"><h4>The Cameron Special</h4><ul><li>Chicken</li><li>Hot Sauce</li><li>White Crust</li></ul></div></div>';

        for (var i = 2; i < 100; i++) {
            htmlStr = htmlStr + '<div class="randomPizzaContainer" id="pizza' + i + '" style="height: 325px;"><div class="col-md-6"><img src="images/pizza.webp" 
                class="img-responsive"></div><div class="col-md-6"><h4>' + randomName() + '</h4><ul>' + makeRandomPizza() + '</ul></div></div>';
        }
        document.getElementById("randomPizzas").innerHTML = htmlStr;  
```  

###For <5ms resize pizza image.  

*   ***change the css width of the pizza image class **_'randomPizzaContainer'_** instead of changing the width individually.***    

```    
      function changePizzaSizes(size) {
        var dx = determineDx(document.querySelectorAll(".randomPizzaContainer")[0], size);
        var newwidth = (document.querySelectorAll(".randomPizzaContainer")[0].offsetWidth + dx) + 'px';
        document.styleSheets[0].cssRules[0].style.width = newwidth;
      }  

```

    
