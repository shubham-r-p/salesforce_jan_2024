({
    
    myArray: 'standard:home',
    
        doInit : function(component, event, helper) {
        // Initialize the icons array with dynamic icon data
        component.set("v.icons", [
            { iconName: 'standard:home', altText: 'Heart' },
            { iconName: 'standard:home', altText: 'Bookmark' },
            // Add more icon objects as needed
        ]);
    },
})