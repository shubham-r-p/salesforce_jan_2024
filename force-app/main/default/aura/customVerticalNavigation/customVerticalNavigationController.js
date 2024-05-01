({
    
    init: function(component, event, helper) {
       
        var iconMap = {
            'Home': 'standard:home',
            'Learnings': 'standard:knowledge',
            'Products': 'standard:product',
            'Orders': 'standard:orders',
            'Software': 'standard:code_playground',
            'Help': 'standard:people'
        };
        
        var mapArray = [];
        for (var key in iconMap) {
            if (iconMap.hasOwnProperty(key)) {
                mapArray.push({key: key, value: iconMap[key]});
            }
        }
        
        component.set('v.iconMap', mapArray);
        
        
       /* component.set("v.iconMap", iconMap);
        var keys = Object.keys(iconMap);
        console.log('iconMap keys:', keys);
        var values = Object.values(iconMap);
        console.log('iconMap values:', values);
        var icons= JSON.parse(JSON.stringify(component.get('v.iconMap')))[0];
        console.log('icons-->',icons);*/
    },
  
    onClick : function(component, event, helper) {
        console.log('in onclick function')
        console.log('Ids:',JSON.parse(JSON.stringify( component.get("v.menuItems"))))
        var menuItems = component.get("v.menuItems");
        var ids = [];
       menuItems.forEach(function(item) {
          ids.push(item.id);
        });
      component.set("v.selectedItemIds", ids);
      console.log('selectedItemIds:', JSON.stringify(ids));
      var getIds= component.get("v.selectedItemIds");
        console.log('getIds:', JSON.stringify(getIds));
        // getting the menuItemId
        var id = event.currentTarget.dataset.menuItemId;
        console.log('id ->', id)
        if (id) {
            console.log('button clicked ->', id)  
            // Using standard navigate function to navigate to the clicked item
            component.getSuper().navigate(id);
            console.log('navigated')
        }
   },
    onSubMenuClick : function(component, event, helper) {
        
        console.log('in subMenu click function')
        // hide or unhides the sub menu ites
        let nextElement = event.currentTarget.nextElementSibling
        if(nextElement.classList.contains('hide')){
            nextElement.classList.remove('hide')
        }else{
            nextElement.classList.add('hide')
            console.log('hiding')
        }

        let downIcon = event.currentTarget.getElementsByClassName('down-icon')
        // rotates the right icon to down side
        if(downIcon.length > 0 && downIcon[0]){
            if(downIcon[0].classList.contains('rotate-icon')){
                downIcon[0].classList.remove('rotate-icon')
            }else{ 
                downIcon[0].classList.add('rotate-icon')
            }
        }
    }
})