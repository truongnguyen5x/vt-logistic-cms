import AuthLogo from 'assets/logo-icon.jpg';
import MenuLogo from 'assets/logo-icon.jpg';
import favicon from 'assets/favicon.ico';

export default {
  config: {
    auth: {
      logo: AuthLogo,
    },
    head: {
      favicon: favicon,
    },
    menu: {
      logo: MenuLogo,
    }, 
   locales: [
      // 'ar',
      // 'fr',
      // 'cs',
      // 'de',
      // 'dk',
      // 'es',
      // 'he',
      // 'id',
      // 'it',
      // 'ja',
      // 'ko',
      // 'ms',
      // 'nl',
      // 'no',
      // 'pl',
      // 'pt-BR',
      // 'pt',
      // 'ru',
      // 'sk',
      // 'sv',
      // 'th',
      // 'tr',
      // 'uk',
       'en',
       'vi',
      // 'zh-Hans',
      // 'zh',
    ],
	translations: { 'vi-VN': { "app.components.LeftMenu.navbrand.title": "VTL CMS" } }
	
  },
  bootstrap(app) {
    console.log('App started', app);
  },
};
