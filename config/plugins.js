export default ({ env }) => ({
	graphql: {
		config: {
			playgroundAlways: true
		}
	},
	 ckeditor5: {
	    enabled: true,
	    resolve: "./src/plugins/strapi-plugin-ckeditor"
  	},
	 seo: {
	    enabled: true,
  	},
	slugify: {
	        enabled: true,
        	config: {
	          contentTypes: {
        	    news: {
		          field: 'slug',
        		  references: 'title',
        		},
      		  },
    		},
  	},
});
