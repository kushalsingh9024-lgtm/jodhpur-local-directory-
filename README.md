# Jodhpur Local — Business Directory Starter

यह Android मोबाइल से शुरू करने के लिए एक शुरुआती prototype है। इसमें:
- बिजनेस सर्च और कैटेगरी फिल्टर
- Call और WhatsApp लिंक
- बिजनेस जोड़ने का फॉर्म
- Demo admin panel में approve/delete

## बहुत जरूरी सीमाएं
1. यह पहला डेमो है: डेटा केवल उसी ब्राउज़र/डिवाइस के `localStorage` में सेव होता है। दूसरे लोगों को उनका सबमिट किया डेटा नहीं दिखेगा।
2. Demo PIN `2468` असली सुरक्षा नहीं है। HTML/JavaScript में रखा PIN कोई भी देख सकता है।
3. लाइव, multi-user वेबसाइट के लिए Supabase database + Auth + Row Level Security (RLS) जोड़ना जरूरी है। `supabase.sql` शुरुआती database schema है; इसे लागू करने से पहले policies और admin role को सुरक्षित रूप से configure करें।
4. डेमो में दिए Demo listings काल्पनिक हैं। पब्लिश करने से पहले इन्हें हटाएं और केवल सत्यापित, अनुमति-प्राप्त बिजनेस जानकारी डालें।
5. Justdial का नाम, लोगो, डिजाइन या कॉपीराइट सामग्री न कॉपी करें। अपना अलग ब्रांड/डिजाइन रखें।

## Android मोबाइल से चलाना
सबसे आसान तरीका: GitHub पर repo बनाएं, `index.html` और `supabase.sql` अपलोड करें। GitHub Pages HTML demo को host कर सकता है; GitHub Pages static hosting है और database/backend नहीं चलाता।

### GitHub पर फाइल अपलोड
1. Chrome में https://github.com खोलें और साइन इन/साइन अप करें।
2. `+` → `New repository` चुनें।
3. Repository name: `jodhpur-local-directory`; Public चुनें; `Create repository` दबाएं।
4. `Add file` → `Create new file` चुनें। फ़ाइल का नाम `index.html` रखें।
5. इस ZIP के `index.html` का पूरा कंटेंट कॉपी करके GitHub editor में पेस्ट करें और `Commit changes` करें।
6. फिर `Add file` → `Upload files` से `supabase.sql` और `README.md` अपलोड करें।
7. Repo में `Settings` → `Pages` खोलें। `Deploy from a branch` चुनें, branch `main`, folder `/(root)` चुनें, फिर `Save` करें।
8. कुछ मिनट बाद Pages सेक्शन में आपकी साइट का URL दिखेगा, आम तौर पर `https://YOUR-USERNAME.github.io/jodhpur-local-directory/`। यह उदाहरण है; अपना वास्तविक URL GitHub में देखें।

## लाइव database के लिए
1. https://supabase.com पर free project बनाएं।
2. SQL Editor में `supabase.sql` खोलकर उसकी सामग्री review करके चलाएं।
3. `businesses` table में RLS और admin permissions को सही तरह सेट करें। केवल schema चलाने से सुरक्षित admin dashboard अपने-आप नहीं बनता।
4. Frontend में Supabase JS client जोड़ें; public anon key ही browser में रखें, कभी `service_role` key नहीं।
5. Admin के लिए Supabase Auth और `profiles.is_admin` जैसी verified role व्यवस्था बनाएं; admin role किसी public form से खुद set न होने दें।
6. Public listing पढ़ने की अनुमति केवल `approved` rows तक सीमित करें। Insert में नई listing का status हमेशा `pending` रखें। Approve/delete केवल authenticated admin कर सके।
7. Live करने से पहले spam protection, validation, privacy policy, terms, data backup और phone-number consent जोड़ें।

## अगले विकास चरण
- Supabase से listing fetch/insert करना
- Admin Auth और सुरक्षित approve/delete actions
- बिजनेस की तस्वीरें और Google Maps link
- SEO: हर business के लिए अलग URL और metadata
- Listing owner verification और report listing सुविधा
