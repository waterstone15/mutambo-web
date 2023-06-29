= page-title 'Privacy - Mutambo' replace=true separator=' → '

.min-w-screen.min-h-screen
  .flex.flex-col.justify-between.w-screen.min-h-screen.bg-neutral-100

    % TopNav @isLoggedIn=this.model.isLoggedIn

    / div(classname='grid')
    /   div(classname='flex items-center justify-center')
    /     div(classname='bg-white bg-opacity-100 rounded-lg shadow grid p-10 max-w-screen-md mx-2', style='{{', gridtemplatecolumns:='', 'auto='', 1fr'='', }}='')
    /       div
    /         h2(classname='font-black text-xl mb-2') Privacy Policy
    /         h3(classname='text-warm-gray-600') Effective date: July 1, 2020
    /         ul(classname='mt-6 list-decimal ml-6')
    /           li(classname='mt-1')
    /             link(href='#1')
    /             a(href='#1', classname='text-light-blue-500 hover:text-light-blue-600 hover:underline') Introduction
    /           li(classname='mt-1')
    /             link(href='#2')
    /             a(href='#2', classname='text-light-blue-500 hover:text-light-blue-600 hover:underline') Definitions
    /           li(classname='mt-1')
    /             link(href='#3')
    /             a(href='#3', classname='text-light-blue-500 hover:text-light-blue-600 hover:underline') Information Collection and Use
    /           li(classname='mt-1')
    /             link(href='#4')
    /             a(href='#4', classname='text-light-blue-500 hover:text-light-blue-600 hover:underline') Types of Data Collected
    /           li(classname='mt-1')
    /             link(href='#5')
    /             a(href='#5', classname='text-light-blue-500 hover:text-light-blue-600 hover:underline') Use of Data
    /           li(classname='mt-1')
    /             link(href='#6')
    /             a(href='#6', classname='text-light-blue-500 hover:text-light-blue-600 hover:underline') Retention of Data
    /           li(classname='mt-1')
    /             link(href='#7')
    /             a(href='#7', classname='text-light-blue-500 hover:text-light-blue-600 hover:underline') Transfer of Data
    /           li(classname='mt-1')
    /             link(href='#8')
    /             a(href='#8', classname='text-light-blue-500 hover:text-light-blue-600 hover:underline') Disclosure of Data
    /           li(classname='mt-1')
    /             link(href='#9')
    /             a(href='#9', classname='text-light-blue-500 hover:text-light-blue-600 hover:underline') Security of Data
    /           li(classname='mt-1')
    /             link(href='#10')
    /             a(href='#10', classname='text-light-blue-500 hover:text-light-blue-600 hover:underline') General Data Protection Regulation (GDPR)
    /           li(classname='mt-1')
    /             link(href='#11')
    /             a(href='#11', classname='text-light-blue-500 hover:text-light-blue-600 hover:underline') California Privacy Protection Act (CalOPPA)
    /           li(classname='mt-1')
    /             link(href='#12')
    /             a(href='#12', classname='text-light-blue-500 hover:text-light-blue-600 hover:underline') Service Providers
    /           li(classname='mt-1')
    /             link(href='#13')
    /             a(href='#13', classname='text-light-blue-500 hover:text-light-blue-600 hover:underline') CI/CD tools
    /           li(classname='mt-1')
    /             link(href='#14')
    /             a(href='#14', classname='text-light-blue-500 hover:text-light-blue-600 hover:underline') Payments
    /           li(classname='mt-1')
    /             link(href='#15')
    /             a(href='#15', classname='text-light-blue-500 hover:text-light-blue-600 hover:underline') Links to Other Sites
    /           li(classname='mt-1')
    /             link(href='#16')
    /             a(href='#16', classname='text-light-blue-500 hover:text-light-blue-600 hover:underline') Children&apos;s Privacy
    /           li(classname='mt-1')
    /             link(href='#17')
    /             a(href='#17', classname='text-light-blue-500 hover:text-light-blue-600 hover:underline') Changes to This Privacy Policy
    /           li(classname='mt-1')
    /             link(href='#18')
    /             a(href='#18', classname='text-light-blue-500 hover:text-light-blue-600 hover:underline') Contact Us
    /         h4#1(classname='mb-3 pt-8 font-bold underline') 1. Introduction
    /         p(classname='mb-3 leading-7') Welcome to Owl Mail.
    /         p(classname='mb-3 leading-7')
    /           | Owl Mail (&ldquo;us&rdquo;, &ldquo;we&rdquo;, or &ldquo;our&rdquo;) operates https://owlmail.io (hereinafter referred to as &ldquo;Service&rdquo;).
    /         p(classname='mb-3 leading-7')
    /           | We use your data to provide and improve Service. By using Service, you agree to the collection and use of information in accordance with this policy. Unless otherwise defined in this Privacy Policy, the terms used in this Privacy Policy have the same meanings as in our Terms and Conditions.
    /         p(classname='mb-3 leading-7')
    /           | Our Terms and Conditions (&ldquo;Terms&rdquo;) govern all use of our Service and together with the Privacy Policy constitutes your agreement with us (&ldquo;agreement&rdquo;).
    /         h4#2(classname='mb-3 pt-8 font-bold underline') 2. Definitions
    /         p(classname='mb-3 leading-7') SERVICE means the https://owlmail.io website operated by Owl Mail.
    /         p(classname='mb-3 leading-7')
    /           | PERSONAL DATA means data about a living individual who can be identified from those data (or from those and other information either in our possession or likely to come into our possession).
    /         p(classname='mb-3 leading-7')
    /           | USAGE DATA is data collected automatically either generated by the use of Service or from Service infrastructure itself (for example, the duration of a page visit).
    /         p(classname='mb-3 leading-7') COOKIES are small files stored on your device (computer or mobile device).
    /         p(classname='mb-3 leading-7')
    /           | DATA CONTROLLER means a natural or legal person who (either alone or jointly or in common with other persons) determines the purposes for which and the manner in which any personal data are, or are to be, processed. For the purpose of this Privacy Policy, we are a Data Controller of your data.
    /         p(classname='mb-3 leading-7')
    /           | DATA PROCESSORS (OR SERVICE PROVIDERS) means any natural or legal person who processes the data on behalf of the Data Controller. We may use the services of various Service Providers in order to process your data more effectively.
    /         p(classname='mb-3 leading-7') DATA SUBJECT is any living individual who is the subject of Personal Data.
    /         p(classname='mb-3 leading-7')
    /           | THE USER is the individual using our Service. The User corresponds to the Data Subject, who is the subject of Personal Data.
    /         h4#3(classname='mb-3 pt-8 font-bold underline') 3. Information Collection and Use
    /         p(classname='mb-3 leading-7')
    /           | We collect several different types of information for various purposes to provide and improve our Service to you.
    /         h4#4(classname='mb-3 pt-8 font-bold underline') 4. Types of Data Collected
    /         h5(classname='mb-3 font-semibold') Personal Data
    /         p(classname='mb-3 leading-7')
    /           | While using our Service, we may ask you to provide us with certain personally identifiable information that can be used to contact or identify you (&ldquo;Personal Data&rdquo;). Personally identifiable information may include, but is not limited to:
    /         p(classname='mb-3 leading-7') (a) Email address
    /         p(classname='mb-3 leading-7')
    /           | We may use your Personal Data to contact you with newsletters, marketing or promotional materials and other information that may be of interest to you. You may opt out of receiving any, or all, of these communications from us by emailing at hello@owlmail.io.
    /         h5(classname='mb-3 font-semibold') Usage Data
    /         p(classname='mb-3 leading-7')
    /           | We may also collect information that your browser sends whenever you visit our Service or when you access Service by or through a mobile device (&ldquo;Usage Data&rdquo;).
    /         p(classname='mb-3 leading-7')
    /           | This Usage Data may include information such as your computer&apos;s Internet Protocol address (e.g. IP address), browser type, browser version, the pages of our Service that you visit, the time and date of your visit, the time spent on those pages, unique device identifiers and other diagnostic data.
    /         p(classname='mb-3 leading-7')
    /           | When you access Service with a mobile device, this Usage Data may include information such as the type of mobile device you use, your mobile device unique ID, the IP address of your mobile device, your mobile operating system, the type of mobile Internet browser you use, unique device identifiers and other diagnostic data.
    /         h5(classname='mb-3 font-semibold') Tracking Cookies Data
    /         p(classname='mb-3 leading-7')
    /           | We use cookies and similar tracking technologies to track the activity on our Service and we hold certain information.
    /         p(classname='mb-3 leading-7')
    /           | Cookies are files with a small amount of data which may include an anonymous unique identifier. Cookies are sent to your browser from a website and stored on your device. Other tracking technologies are also used such as beacons, tags and scripts to collect and track information and to improve and analyze our Service.
    /         p(classname='mb-3 leading-7')
    /           | You can instruct your browser to refuse all cookies or to indicate when a cookie is being sent. However, if you do not accept cookies, you may not be able to use some portions of our Service.
    /         p(classname='mb-3 leading-7') Examples of Cookies we use:
    /         p(classname='mb-3 leading-7') (a) Session Cookies: We use Session Cookies to operate our Service.
    /         p(classname='mb-3 leading-7')
    /           | (b) Preference Cookies: We use Preference Cookies to remember your preferences and various settings.
    /         p(classname='mb-3 leading-7') (c) Security Cookies: We use Security Cookies for security purposes.
    /         h4#5(classname='mb-3 pt-8 font-bold underline') 5. Use of Data
    /         p(classname='mb-3 leading-7') Owl Mail uses the collected data for various purposes:
    /         p(classname='mb-3 leading-7') (a) to provide and maintain our Service;
    /         p(classname='mb-3 leading-7') (b) to notify you about changes to our Service;
    /         p(classname='mb-3 leading-7')
    /           | (c) to allow you to participate in interactive features of our Service when you choose to do so;
    /         p(classname='mb-3 leading-7') (d) to provide customer support;
    /         p(classname='mb-3 leading-7')
    /           | (e) to gather analysis or valuable information so that we can improve our Service;
    /         p(classname='mb-3 leading-7') (f) to monitor the usage of our Service;
    /         p(classname='mb-3 leading-7') (g) to detect, prevent and address technical issues;
    /         p(classname='mb-3 leading-7') (h) to fulfill any other purpose for which you provide it;
    /         p(classname='mb-3 leading-7')
    /           | (i) to carry out our obligations and enforce our rights arising from any contracts entered into between you and us, including for billing and collection;
    /         p(classname='mb-3 leading-7')
    /           | (j) to provide you with notices about your account and/or subscription, including expiration and renewal notices, email-instructions, etc.;
    /         p(classname='mb-3 leading-7')
    /           | (k) to provide you with news, special offers and general information about other goods, services and events which we offer that are similar to those that you have already purchased or enquired about unless you have opted not to receive such information;
    /         p(classname='mb-3 leading-7') (l) in any other way we may describe when you provide the information;
    /         p(classname='mb-3 leading-7') (m) for any other purpose with your consent.
    /         h4#6(classname='mb-3 pt-8 font-bold underline') 6. Retention of Data
    /         p(classname='mb-3 leading-7')
    /           | We will retain your Personal Data only for as long as is necessary for the purposes set out in this Privacy Policy. We will retain and use your Personal Data to the extent necessary to comply with our legal obligations (for example, if we are required to retain your data to comply with applicable laws), resolve disputes, and enforce our legal agreements and policies.
    /         p(classname='mb-3 leading-7')
    /           | We will also retain Usage Data for internal analysis purposes. Usage Data is generally retained for a shorter period, except when this data is used to strengthen the security or to improve the functionality of our Service, or we are legally obligated to retain this data for longer time periods.
    /         h4#7(classname='mb-3 pt-8 font-bold underline') 7. Transfer of Data
    /         p(classname='mb-3 leading-7')
    /           | Your information, including Personal Data, may be transferred to &ndash; and maintained on &ndash; computers located outside of your state, province, country or other governmental jurisdiction where the data protection laws may differ from those of your jurisdiction.
    /         p(classname='mb-3 leading-7')
    /           | If you are located outside United States and choose to provide information to us, please note that we transfer the data, including Personal Data, to United States and process it there.
    /         p(classname='mb-3 leading-7')
    /           | Your consent to this Privacy Policy followed by your submission of such information represents your agreement to that transfer.
    /         p(classname='mb-3 leading-7')
    /           | Owl Mail will take all the steps reasonably necessary to ensure that your data is treated securely and in accordance with this Privacy Policy and no transfer of your Personal Data will take place to an organisation or a country unless there are adequate controls in place including the security of your data and other personal information.
    /         h4#8(classname='mb-3 pt-8 font-bold underline') 8. Disclosure of Data
    /         p(classname='mb-3 leading-7') We may disclose personal information that we collect, or you provide:
    /         p(classname='mb-3 leading-7 font-medium') (a) Disclosure for Law Enforcement.
    /         p(classname='mb-3 leading-7')
    /           | Under certain circumstances, we may be required to disclose your Personal Data if required to do so by law or in response to valid requests by public authorities.
    /         p(classname='mb-3 leading-7 font-medium') (b) Business Transaction.
    /         p(classname='mb-3 leading-7')
    /           | If we or our subsidiaries are involved in a merger, acquisition or asset sale, your Personal Data may be transferred.
    /         p(classname='mb-3 leading-7 font-medium') (c) Other cases. We may also disclose your information:
    /         p(classname='mb-3 leading-7') (i) to fulfill the purpose for which you provide it;
    /         p(classname='mb-3 leading-7') (ii) for any other purpose disclosed by us when you provide the information;
    /         p(classname='mb-3 leading-7') (iii) with your consent in any other cases.
    /         h4#9(classname='mb-3 pt-8 font-bold underline') 9. Security of Data
    /         p(classname='mb-3 leading-7')
    /           | The security of your data is important to us but remember that no method of transmission over the Internet or method of electronic storage is 100% secure. While we strive to use commercially acceptable means to protect your Personal Data, we cannot guarantee its absolute security.
    /         h4#10(classname='mb-3 pt-8 font-bold underline') 10. General Data Protection Regulation (GDPR)
    /         p(classname='mb-3 leading-7')
    /           | If you are a resident of the European Union (EU) and European Economic Area (EEA), you have certain data protection rights, covered by GDPR. &ndash; See more at https://eur-lex.europa.eu/eli/reg/2016/679/oj
    /         p(classname='mb-3 leading-7')
    /           | We aim to take reasonable steps to allow you to correct, amend, delete, or limit the use of your Personal Data.
    /         p(classname='mb-3 leading-7')
    /           | If you wish to be informed what Personal Data we hold about you and if you want it to be removed from our systems, please email us at hello@owlmail.io.
    /         p(classname='mb-3 leading-7') In certain circumstances, you have the following data protection rights:
    /         p(classname='mb-3 leading-7') (a) the right to access, update or to delete the information we have on you;
    /         p(classname='mb-3 leading-7')
    /           | (b) the right of rectification. You have the right to have your information rectified if that information is inaccurate or incomplete;
    /         p(classname='mb-3 leading-7')
    /           | (c) the right to object. You have the right to object to our processing of your Personal Data;
    /         p(classname='mb-3 leading-7')
    /           | (d) the right of restriction. You have the right to request that we restrict the processing of your personal information;
    /         p(classname='mb-3 leading-7')
    /           | (e) the right to data portability. You have the right to be provided with a copy of your Personal Data in a structured, machine-readable and commonly used format;
    /         p(classname='mb-3 leading-7')
    /           | (f) the right to withdraw consent. You also have the right to withdraw your consent at any time where we rely on your consent to process your personal information.
    /         p(classname='mb-3 leading-7')
    /           | Please note that we may ask you to verify your identity before responding to such requests. Please note, we may not able to provide Service without some necessary data.
    /         p(classname='mb-3 leading-7')
    /           | You have the right to complain to a Data Protection Authority about our collection and use of your Personal Data. For more information, please contact your local data protection authority in the European Economic Area (EEA).
    /         h4#11(classname='mb-3 pt-8 font-bold underline') 11. California Privacy Protection Act (CalOPPA)
    /         p(classname='mb-3 leading-7')
    /           | CalOPPA is the first state law in the United States to require commercial websites and online services to post a privacy policy. The law&rsquo;s reach stretches well beyond California to require a person or company in the United States (and conceivable the world) that operates websites collecting personally identifiable information from California consumers to post a conspicuous privacy policy on its website stating exactly the information being collected and those individuals with whom it is being shared, and to comply with this policy. &ndash; See more at: https://consumercal.org/about-cfc/cfc-education-foundation/california-online-privacy-protection-act-caloppa-3/.
    /         p(classname='mb-3 leading-7') According to CalOPPA we agree to the following:
    /         p(classname='mb-3 leading-7') (a) users can visit our site anonymously;
    /         p(classname='mb-3 leading-7')
    /           | (b) our Privacy Policy link includes the word &ldquo;Privacy&rdquo;, and can easily be found on the page specified above on the home page of our website;
    /         p(classname='mb-3 leading-7')
    /           | (c) users will be notified of any privacy policy changes on our Privacy Policy Page;
    /         p(classname='mb-3 leading-7')
    /           | (d) users are able to change their personal information by emailing us at hello@owlmail.io.
    /         p(classname='mb-3 leading-7') Our Policy on &ldquo;Do Not Track&rdquo; Signals:
    /         p(classname='mb-3 leading-7')
    /           | We honor Do Not Track signals and do not track, plant cookies, or use advertising when a Do Not Track browser mechanism is in place. Do Not Track is a preference you can set in your web browser to inform websites that you do not want to be tracked.
    /         p(classname='mb-3 leading-7')
    /           | You can enable or disable Do Not Track by visiting the Preferences or Settings page of your web browser.
    /         h4#12(classname='mb-3 pt-8 font-bold underline') 12. Service Providers
    /         p(classname='mb-3 leading-7')
    /           | We may employ third party companies and individuals to facilitate our Service (&ldquo;Service Providers&rdquo;), provide Service on our behalf, perform Service-related services or assist us in analysing how our Service is used.
    /         p(classname='mb-3 leading-7')
    /           | These third parties have access to your Personal Data only to perform these tasks on our behalf and are obligated not to disclose or use it for any other purpose.
    /         h4#13(classname='mb-3 pt-8 font-bold underline') 13. CI/CD tools
    /         p(classname='mb-3 leading-7')
    /           | We may use third-party Service Providers to automate the development process of our Service.
    /         p(classname='mb-3 leading-7 font-semibold') GitHub
    /         p(classname='mb-3 leading-7') GitHub is provided by GitHub, Inc.
    /         p(classname='mb-3 leading-7')
    /           | GitHub is a development platform to host and review code, manage projects, and build software.
    /         p(classname='mb-3 leading-7')
    /           | For more information on what data GitHub collects for what purpose and how the protection of the data is ensured, please visit the GitHub Privacy Policy page.
    /         h4#14(classname='mb-3 pt-8 font-bold underline') 14. Payments
    /         p(classname='mb-3 leading-7')
    /           | We may provide paid products and/or services within Service. In that case, we use third-party services for payment processing (e.g. payment processors).
    /         p(classname='mb-3 leading-7')
    /           | We will not store or collect your payment card details. That information is provided directly to our third-party payment processors whose use of your personal information is governed by their Privacy Policy. These payment processors adhere to the standards set by PCI-DSS as managed by the PCI Security Standards Council, which is a joint effort of brands like Visa, Mastercard, American Express and Discover. PCI-DSS requirements help ensure the secure handling of payment information.
    /         p(classname='mb-3 leading-7') The payment processors we work with are:
    /         p(classname='mb-3 leading-7 font-semibold') Stripe
    /         p(classname='mb-3 leading-7') Their Privacy Policy can be viewed at: https://stripe.com/us/privacy.
    /         h4#15(classname='mb-3 pt-8 font-bold underline') 15. Links to Other Sites
    /         p(classname='mb-3 leading-7')
    /           | Our Service may contain links to other sites that are not operated by us. If you click a third party link, you will be directed to that third party&apos;s site. We strongly advise you to review the Privacy Policy of every site you visit.
    /         p(classname='mb-3 leading-7')
    /           | We have no control over and assume no responsibility for the content, privacy policies or practices of any third party sites or services.
    /         h4#16(classname='mb-3 pt-8 font-bold underline') 16. Children&apos;s Privacy
    /         p(classname='mb-3 leading-7')
    /           | Our Services are not intended for use by children under the age of 18 (&ldquo;Child&rdquo; or &ldquo;Children&rdquo;).
    /         p(classname='mb-3 leading-7')
    /           | We do not knowingly collect personally identifiable information from Children under 18. If you become aware that a Child has provided us with Personal Data, please contact us. If we become aware that we have collected Personal Data from Children without verification of parental consent, we take steps to remove that information from our servers.
    /         h4#17(classname='mb-3 pt-8 font-bold underline') 17. Changes to This Privacy Policy
    /         p(classname='mb-3 leading-7')
    /           | We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.
    /         p(classname='mb-3 leading-7')
    /           | We will let you know via email and/or a prominent notice on our Service, prior to the change becoming effective and update &ldquo;effective date&rdquo; at the top of this Privacy Policy.
    /         p(classname='mb-3 leading-7')
    /           | You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.
    /         h4#18(classname='mb-3 pt-8 font-bold underline') 18. Contact Us
    /         p(classname='mb-3 leading-7') If you have any questions about this Privacy Policy, please contact us:
    /         p(classname='mb-3 leading-7') By email: hello@owlmail.io.
    /         h5(classname='mb-3 font-semibold')
    /         p(classname='mb-3 leading-7')
    /         p(classname='mb-3 leading-7')
    /         p(classname='mb-3 leading-7')
    /         p(classname='mb-3 leading-7')
    /         p(classname='mb-3 leading-7')
    /         p(classname='mb-3 leading-7')
    /         p(classname='mb-3 leading-7')
    /         p(classname='mb-3 leading-7')

  % Footer
