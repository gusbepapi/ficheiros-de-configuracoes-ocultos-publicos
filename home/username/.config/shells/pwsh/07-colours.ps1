#!/usr/bin/env pwsh

## 🇬🇧 Restore
## 🇫🇷 Restaurer
## 🇪🇸 Restaurar
## 🇮🇹 Ripristinare
## 🇵🇹 Restaurar
## 🇩🇪 Wiederherstellen
## 🇳🇱 Herstellen
## 🏴󠁥󠁳󠁣󠁴󠁿 Restaurar
## 🇷🇴 Restaurare
## 🇬🇷 Αποκατάσταση
## 🇬🇪 აღდგენა
## 🇺🇦 Відновити
$nc = "`e[0m"

## 🇬🇧 Text foreground colour
## 🇫🇷 Couleur de premier plan du texte
## 🇪🇸 colour de primer plano del texto
## 🇮🇹 coloure del testo in primo piano
## 🇵🇹 Cor da frente do texto
## 🇩🇪 Vordergrundfarbe des Textes
## 🇳🇱 Voorgrondkleur van de tekst
## 🏴󠁥󠁳󠁣󠁴󠁿 colour de primer pla del text
## 🇷🇴 Culoarea de prim-plan a textului
## 🇬🇷 Χρώμα προεξοχής κειμένου
## 🇬🇪 ტექსტის წინა ფერის
## 🇺🇦 Колір переднього плану тексту
$frg = "38;2"

## 🇬🇧 Text background colour
## 🇫🇷 Couleur d’arrière-plan du texte
## 🇪🇸 colour de fondo del texto
## 🇮🇹 coloure di sfondo del testo
## 🇵🇹 Cor de fundo do texto
## 🇩🇪 Hintergrundfarbe des Textes
## 🇳🇱 Achtergrondkleur van de tekst
## 🏴󠁥󠁳󠁣󠁴󠁿 colour de fons del text
## 🇷🇴 Culoarea de fundal a textului
## 🇬🇷 Χρώμα φόντου κειμένου
## 🇬🇪 ტექსტის ფონური ფერის
## 🇺🇦 Колір фону тексту
$bg = "48;2"

## 🇬🇧 Italic
## 🇫🇷 Italique
## 🇪🇸 Cursiva
## 🇮🇹 Corsivo
## 🇵🇹 Itálico
## 🇩🇪 Kursiv
## 🇳🇱 Cursief
## 🏴󠁥󠁳󠁣󠁴󠁿 Itàlic
## 🇷🇴 Italic
## 🇬🇷 Ιταλικά
## 🇬🇪 კურსივი
## 🇺🇦 Курсив
$i = "3"

## 🇬🇧 Bold
## 🇫🇷 Gras
## 🇪🇸 Negrita
## 🇮🇹 Grassetto
## 🇵🇹 Negrito
## 🇩🇪 Fett
## 🇳🇱 Vetgedrukt
## 🏴󠁥󠁳󠁣󠁴󠁿 Negreta
## 🇷🇴 Gras
## 🇬🇷 Έντονα
## 🇬🇪 მუქი
## 🇺🇦 Жирний
$n = "1"

## 🇬🇧 Others
## 🇫🇷 Autres
## 🇪🇸 Otros
## 🇮🇹 Altri
## 🇵🇹 Outros
## 🇩🇪 Andere
## 🇳🇱 Anderen
## 🏴󠁥󠁳󠁣󠁴󠁿 Altres
## 🇷🇴 Altele
## 🇬🇷 Άλλοι
## 🇬🇪 სხვა
## 🇺🇦 Інші
$m = "m"

# 🇬🇧 Colours
# 🇫🇷 Couleurs
# 🇪🇸 coloures
# 🇮🇹 colouri
# 🇵🇹 Cores
# 🇩🇪 Farben
# 🇳🇱 Kleuren
# 🏴󠁥󠁳󠁣󠁴󠁿 colours
# 🇷🇴 Culori
# 🇬🇷 Χρώματα
# 🇬🇪 ფერები
# 🇺🇦 Кольори

## ITAÚ
### 🇬🇧 The Itaú, Iti, Íon and Personnalité colours were derived from Itaú applications and websites
### 🇫🇷 Les couleurs Itaú, Iti, Íon et Personnalité ont été dérivées des applications et sites web d’Itaú
### 🇪🇸 Los coloures Itaú, Iti, Íon y Personnalité se derivaron de las aplicaciones y sitios web de Itaú
### 🇮🇹 I colouri Itaú, Iti, Íon e Personnalité sono stati derivati dalle applicazioni e dai siti web di Itaú
### 🇵🇹 As cores de Itaú, Iti, Íon e Personnalité foram derivadas das aplicações e sites da Itaú
### 🇩🇪 Die Farben Itaú, Iti, Íon und Personnalité stammen von den Itaú-Anwendungen und -Websites
### 🇳🇱 De kleuren Itaú, Iti, Íon en Personnalité zijn afgeleid van de Itaú-toepassingen en -websites
### 🏴󠁥󠁳󠁣󠁴󠁿 Els colours Itaú, Iti, Íon i Personnalité es van derivar de les aplicacions i llocs web d’Itaú
### 🇷🇴 Culorile Itaú, Iti, Íon și Personnalité au fost derivate din aplicațiile și site-urile web Itaú
### 🇬🇷 Τα χρώματα Itaú, Iti, Íon και Personnalité προήλθαν από τις εφαρμογές και τους ιστότοπους του Itaú
### 🇬🇪 Itaú, Iti, Íon და Personnalité ფერები წარმოიშვა Itaú-ის აპლიკაციებიდან და ვებსაიტებიდან
### 🇺🇦 Кольори Itaú, Iti, Íon та Personnalité були отримані з додатків та веб-сайтів Itaú

## LEAGUE OF LEGENDS
### 🇬🇧 Derived from the Runeterra regions page on the League of Legends website:
### 🇫🇷 Dérivé de la page des régions de Runeterra sur le site de League of Legends :
### 🇪🇸 Derivado de la página de regiones de Runeterra en el sitio web de League of Legends:
### 🇮🇹 Derivato dalla pagina delle regioni di Runeterra sul sito di League of Legends:
### 🇵🇹 Derivado da página de regiões de Runeterra no site League of Legends:
### 🇩🇪 Abgeleitet von der Seite der Runeterra-Regionen auf der Website von League of Legends:
### 🇳🇱 Afgeleid van de pagina over de Runeterra-regio's op de League of Legends-website:
### 🏴󠁥󠁳󠁣󠁴󠁿 Derivat de la pàgina de regions de Runeterra al lloc web de League of Legends:
### 🇷🇴 Derivat de pagina regiunilor Runeterra de pe site-ul League of Legends:
### 🇬🇷 Παράγωγο από τη σελίδα περιοχών του Ρουντέρα στον ιστότοπο του League of Legends:
### 🇬🇪 მიღებულია რუნეტერა რეგიონების გვერდიდან League of Legends ვებსაიტზე:
### 🇺🇦 Походить зі сторінки регіонів Рунтерри на сайті League of Legends:
###
### 🇬🇧 References
### 🇫🇷 Références
### 🇪🇸 Referencias
### 🇮🇹 Riferimenti
### 🇵🇹 Referências
### 🇩🇪 Referenzen
### 🇳🇱 Verwijzingen
### 🏴󠁥󠁳󠁣󠁴󠁿 Referències
### 🇷🇴 Referințe
### 🇬🇷 Αναφορές
### 🇬🇪 მითითებები
### 🇺🇦 Посилання
### https://universe.leagueoflegends.com/pt_BR/
### https://na.leagueoflegends.com/en/featured/piltover

### 🇬🇧 Defining a function to convert hexadecimal code format to RGB ANSI format
### 🇫🇷 Définir une fonction pour convertir le format de code hexadécimal en format RGB ANSI
### 🇪🇸 Definiendo una función para convertir el formato de código hexadecimal a formato RGB ANSI
### 🇮🇹 Definire una funzione per convertire il formato del codice esadecimale in formato RGB ANSI
### 🇵🇹 A definir uma função para converter o formato de código hexadecimal para o formato RGB ANSI
### 🇩🇪 Eine Funktion definieren, um das hexadezimale Codeformat in das RGB ANSI-Format zu konvertieren
### 🇳🇱 Een functie definiëren om het hexadecimale codeformaat naar het RGB ANSI-formaat te converteren
### 🏴󠁥󠁳󠁣󠁴󠁿 Definint una funció per convertir el format de codi hexadecimal al format RGB ANSI
### 🇷🇴 Definirea unei funcții pentru a converti formatul codului hexazecimal în format RGB ANSI
### 🇬🇷 Ορισμός μιας συνάρτησης για τη μετατροπή της μορφής κωδικού δεκαεξαδικού σε μορφή RGB ANSI
### 🇬🇪 ფუნქციის განსაზღვრა, რომ გარდაქმნას ექვსკუთხა კოდის ფორმატი RGB ANSI ფორმატში
### 🇺🇦 Визначення функції для перетворення формату шістнадцяткового коду в формат RGB ANSI
function hex_to_rgb 
{
  param ([string]$hex)

  # 🇬🇧 Removing the hash character from the beginning of the hexadecimal code
  # 🇫🇷 Suppression du caractère dièse au début du code hexadécimal
  # 🇪🇸 Eliminación del carácter de hash al principio del código hexadecimal
  # 🇮🇹 Rimozione del carattere hash all’inizio del codice esadecimale
  # 🇵🇹 Remoção do caractere hash do início do código hexadecimal
  # 🇩🇪 Entfernen des Hash-Zeichens am Anfang des hexadezimalen Codes
  # 🇳🇱 Het verwijderen van het hash-teken aan het begin van de hexadecimale code
  # 🏴󠁥󠁳󠁣󠁴󠁿 Eliminació del caràcter de hash al principi del codi hexadecimal
  # 🇷🇴 Eliminarea caracterului hash de la începutul codului hexazecimal
  # 🇬🇷 Αφαίρεση του χαρακτήρα hash στην αρχή του δεκαεξαδικού κώδικα
  # 🇬🇪 ჰეშის სიმბოლოს წაშლა ექვსკუთხა კოდის დასაწყისში
  # 🇺🇦 Видалення символу хешу на початку шістнадцяткового коду
  $hex = $hex.TrimStart('#')
    
  # 🇬🇧 Extracting the red, green, and blue components from the hexadecimal code
  # 🇫🇷 Extraction des composants rouge, vert et bleu du code hexadécimal
  # 🇪🇸 Extracción los componentes rojo, verde y azul del código hexadecimal
  # 🇮🇹 Estrazione dei componenti rosso, verde e blu dal codice esadecimale
  # 🇵🇹 Extração dos componentes vermelho, verde e azul do código hexadecimal
  # 🇩🇪 Extrahieren der roten, grünen und blauen Komponenten aus dem hexadezimalen Code
  # 🇳🇱 Het extraheren van de rode, groene en blauwe componenten uit de hexadecimale code
  # 🏴󠁥󠁳󠁣󠁴󠁿 Extracció dels components vermell, verd i blau del codi hexadecimal
  # 🇷🇴 Extracția componentelor roșu, verde și albastru din codul hexazecimal
  # 🇬🇷 Εξαγωγή των κόκκινων, πράσινων και μπλε συστατικών από τον δεκαεξαδικό κώδικα
  # 🇬🇪 წითელი, მწვანე და ლურჯი კომპონენტების გამოყოფა ექვსკუთხა კოდიდან
  # 🇺🇦 Витягування червоного, зеленого та синього компонентів з шістнадцяткового коду
  $r = [convert]::ToInt32($hex.Substring(0, 2), 16)
  $g = [convert]::ToInt32($hex.Substring(2, 2), 16)
  $b = [convert]::ToInt32($hex.Substring(4, 2), 16)

  # 🇬🇧 Printing the ANSI RGB code
  # 🇫🇷 Impression du code RGB ANSI
  # 🇪🇸 Imprimir el código RGB ANSI
  # 🇮🇹 Stampa del codice RGB ANSI
  # 🇵🇹 Impressão do código RGB ANSI
  # 🇩🇪 Drucken des ANSI RGB-Codes
  # 🇳🇱 Het afdrukken van de ANSI RGB-code
  # 🏴󠁥󠁳󠁣󠁴󠁿 Impressió del codi RGB ANSI
  # 🇷🇴 Tipărirea codului RGB ANSI
  # 🇬🇷 Εκτύπωση του κωδικού RGB ANSI
  # 🇬🇪 ANSI RGB კოდის დაბეჭდვა
  # 🇺🇦 Друк коду ANSI RGB
    "$r;$g;$b"
}

### Itaú Empresas
$hex_itau_empresas_00 = "#D6D0CC"
$hex_itau_empresas_01 = "#89837F"
$hex_itau_empresas_02 = "#EC7000"
$hex_itau_empresas_03 = "#e7eb19"
$hex_itau_empresas_04 = "#003767"

### Itaú Íon
$hex_itau_ion_00 = "#a7ce2e"
$hex_itau_ion_01 = "#c3cec4"
$hex_itau_ion_02 = "#a4b4a6"
$hex_itau_ion_03 = "#133134"
$hex_itau_ion_04 = "#21656c"
$hex_itau_ion_05 = "#687678"
$hex_itau_ion_06 = "#091b1e"
$hex_itau_ion_07 = "#a02bff"

### Itaú Iti
$hex_itau_iti_00 = "#6f1dff"
$hex_itau_iti_01 = "#cfbbf2"
$hex_itau_iti_02 = "#e60073"
$hex_itau_iti_03 = "#facfe1"
$hex_itau_iti_04 = "#fe3386"

### Itaú Personnalité
$hex_itau_personnalite_00 = "#773d38"
$hex_itau_personnalite_01 = "#a35d54"
$hex_itau_personnalite_02 = "#f2cfbc"
$hex_itau_personnalite_03 = "#ffe6d5"
$hex_itau_personnalite_04 = "#ddae60"
$hex_itau_personnalite_05 = "#906d20"
$hex_itau_personnalite_06 = "#10546a"
$hex_itau_personnalite_07 = "#0a3147"
$hex_itau_personnalite_08 = "#192d64"
$hex_itau_personnalite_09 = "#0d1733"

### LGBQTIA+
$hex_lgbt_red    = "#e50000"
$hex_lgbt_orange = "#61360d"
$hex_lgbt_yellow = "#ff8d00"
$hex_lgbt_green  = "#ffee00"
$hex_lgbt_blue   = "#008121"
$hex_lgbt_purple = "#6fd5e7"
$hex_lgbt_pink   = "#004cff"
$hex_lgbt_sky    = "#760188"
$hex_lgbt_brown  = "#ffb0c8"

### Noxus
$hex_noxus_00 = "#211b1b"
$hex_noxus_01 = "#3b2720"
$hex_noxus_02 = "#704b38"
$hex_noxus_03 = "#887062"
$hex_noxus_04 = "#56412c"
$hex_noxus_05 = "#797267"
$hex_noxus_06 = "#c5bca9"
$hex_noxus_07 = "#d0ba7c"
$hex_noxus_08 = "#929f81"
$hex_noxus_09 = "#464f3c"
$hex_noxus_10 = "#202422"
$hex_noxus_11 = "#a79fa2"

### Piltover
$hex_piltover_00 = "#a47462"
$hex_piltover_01 = "#42331c"
$hex_piltover_02 = "#56411f"
$hex_piltover_03 = "#46433e"
$hex_piltover_04 = "#faf7f1"
$hex_piltover_05 = "#cdbe91"
$hex_piltover_06 = "#39362c"
$hex_piltover_07 = "#8b7c48"
$hex_piltover_08 = "#d3c88d"
$hex_piltover_09 = "#556b66"
$hex_piltover_10 = "#0fa2a6"
$hex_piltover_11 = "#1f292a"
$hex_piltover_12 = "#202833"

### Shurima
$hex_shurima_00 = "#75615a"
$hex_shurima_01 = "#402c22"
$hex_shurima_02 = "#a77554"
$hex_shurima_03 = "#ddcbaf"
$hex_shurima_04 = "#85714f"
$hex_shurima_05 = "#b49256"
$hex_shurima_06 = "#d8ae5c"
$hex_shurima_07 = "#eddd97"
$hex_shurima_08 = "#7a786c"
$hex_shurima_09 = "#8ba98f"
$hex_shurima_10 = "#cfe1eb"
$hex_shurima_11 = "#4c3f46"

### Targon
$hex_targon_00 = "#6d5245"
$hex_targon_01 = "#c2b2a8"
$hex_targon_02 = "#c78646"
$hex_targon_03 = "#8a7960"
$hex_targon_04 = "#444e45"
$hex_targon_05 = "#518557"
$hex_targon_06 = "#7b8f8c"
$hex_targon_07 = "#455362"
$hex_targon_08 = "#e5e4e9"
$hex_targon_09 = "#9587ad"
$hex_targon_10 = "#744e98"
$hex_targon_11 = "#2a1e33"

### Zaun
$hex_zaun_00 = "#9e9b50"
$hex_zaun_01 = "#6e765f"
$hex_zaun_02 = "#deffab"
$hex_zaun_03 = "#59a424"

### 🇬🇧 Defining a function to print the text in italics
### 🇫🇷 Définir une fonction pour imprimer le texte en italique
### 🇪🇸 Definiendo una función para imprimir el texto en cursiva
### 🇮🇹 Definire una funzione per stampare il testo in corsivo
### 🇵🇹 Definir uma função para imprimir o texto em itálico
### 🇩🇪 Eine Funktion definieren, um den Text kursiv zu drucken
### 🇳🇱 Een functie definiëren om de tekst cursief af te drukken
### 🏴󠁥󠁳󠁣󠁴󠁿 Definint una funció per imprimir el text en cursiva
### 🇷🇴 Definirea unei funcții pentru a imprima textul în italic
### 🇬🇷 Ορισμός μιας συνάρτησης για να εκτυπώσει το κείμενο σε πλάγια γραφή
### 🇬🇪 ფუნქციის განსაზღვრა, რომ ტექსტი დაბეჭდოს კურსივით
### 🇺🇦 Визначення функції для друку тексту курсивом
function italico { param ([string]$text); return "`e[$i$m$text$nc"}

### 🇬🇧 Defining a function to print the text in bold
### 🇫🇷 Définir une fonction pour imprimer le texte en gras
### 🇪🇸 Definiendo una función para imprimir el texto en negrita
### 🇮🇹 Definire una funzione per stampare il testo in grassetto
### 🇵🇹 Definir uma função para imprimir o texto em negrito
### 🇩🇪 Eine Funktion definieren, um den Text fett zu drucken
### 🇳🇱 Een functie definiëren om de tekst vetgedrukt af te drukken
### 🏴󠁥󠁳󠁣󠁴󠁿 Definint una funció per imprimir el text en negreta
### 🇷🇴 Definirea unei funcții pentru a imprima textul cu litere îngroșate
### 🇬🇷 Ορισμός μιας συνάρτησης για να εκτυπώσει το κείμενο με έντονα γράμματα
### 🇬🇪 ფუნქციის განსაზღვრა ტექსტის გასახდელად
### 🇺🇦 Визначення функції для друку тексту жирним шрифтом
function negrito { param ([string]$text); return "`e[$n$m$text$nc"}

### 🇬🇧 Defining the functions to print a message, using these hexadecimal codes variables
### 🇫🇷 Définir les fonctions pour imprimer un message, en utilisant ces variables de codes hexadécimaux
### 🇪🇸 Definir las funciones para imprimir un mensaje, utilizando estas variables de códigos hexadecimales
### 🇮🇹 Definire le funzioni per stampare un messaggio, utilizzando queste variabili di codici esadecimali
### 🇵🇹 Definir as funções para imprimir uma mensagem, usando estas variáveis de códigos hexadecimais
### 🇩🇪 Eine Funktion definieren, um eine Nachricht zu drucken, indem diese Variablen für hexadezimale Codes verwendet werden
### 🇳🇱 Functies definiëren om een bericht af te drukken, met behulp van deze variabelen voor hexadecimale codes
### 🏴󠁥󠁳󠁣󠁴󠁿 Definint les funcions per imprimir un missatge, utilitzant aquestes variables de codis hexadecimals
### 🇷🇴 Definirea funcțiilor pentru a imprima un mesaj, folosind aceste variabile de coduri hexazecimale
### 🇬🇷 Ορισμός των συναρτήσεων για να εκτυπώσει ένα μήνυμα, χρησιμοποιώντας αυτές τις μεταβλητές κωδικών δεκαεξαδικών
### 🇬🇪 ფუნქციების განსაზღვრა შეტყობინების გასახდელად, ამ ექვსკუთხედი კოდების ცვლადების გამოყენებით
### 🇺🇦 Визначення функцій для друку повідомлення, використовуючи ці змінні шістнадцяткових кодів

#### 🇬🇧 Globally compatible
#### 🇫🇷 Globalement compatible
#### 🇪🇸 Globalmente compatible
#### 🇮🇹 Globalmente compatibile
#### 🇵🇹 Globalmente compatível
#### 🇩🇪 Global kompatibel
#### 🇳🇱 Globaal compatibel
#### 🏴󠁥󠁳󠁣󠁴󠁿 Globalment compatible
#### 🇷🇴 Compatibil global
#### 🇬🇷 Παγκοσμίως συμβατό
#### 🇬🇪 გლობალურად თავსებადია
#### 🇺🇦 Глобально сумісний
function itau_empresas_00 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_itau_empresas_00")$m$text$nc"; }
function itau_empresas_01 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_itau_empresas_01")$m$text$nc"; }
function itau_empresas_02 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_itau_empresas_02")$m$text$nc"; }
function itau_empresas_03 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_itau_empresas_03")$m$text$nc"; }
function itau_empresas_04 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_itau_empresas_04")$m$text$nc"; }

function itau_ion_00 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_itau_ion_00")$m$text$nc"; }
function itau_ion_01 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_itau_ion_01")$m$text$nc"; }
function itau_ion_02 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_itau_ion_02")$m$text$nc"; }
function itau_ion_03 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_itau_ion_03")$m$text$nc"; }
function itau_ion_04 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_itau_ion_04")$m$text$nc"; }
function itau_ion_05 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_itau_ion_05")$m$text$nc"; }
function itau_ion_06 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_itau_ion_06")$m$text$nc"; }
function itau_ion_07 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_itau_ion_07")$m$text$nc"; }

function itau_iti_00 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_itau_iti_00")$m$text$nc"; }
function itau_iti_01 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_itau_iti_01")$m$text$nc"; }
function itau_iti_02 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_itau_iti_02")$m$text$nc"; }
function itau_iti_03 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_itau_iti_03")$m$text$nc"; }
function itau_iti_04 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_itau_iti_04")$m$text$nc"; }

function itau_personnalite_00 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_itau_personnalite_00")$m$text$nc"; }
function itau_personnalite_01 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_itau_personnalite_01")$m$text$nc"; }
function itau_personnalite_02 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_itau_personnalite_02")$m$text$nc"; }
function itau_personnalite_03 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_itau_personnalite_03")$m$text$nc"; }
function itau_personnalite_04 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_itau_personnalite_04")$m$text$nc"; }
function itau_personnalite_05 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_itau_personnalite_05")$m$text$nc"; }
function itau_personnalite_06 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_itau_personnalite_06")$m$text$nc"; }
function itau_personnalite_07 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_itau_personnalite_07")$m$text$nc"; }
function itau_personnalite_08 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_itau_personnalite_08")$m$text$nc"; }
function itau_personnalite_09 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_itau_personnalite_09")$m$text$nc"; }

function lgbt_red      { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_lgbt_red")$m$text$nc";     }
function lgbt_brown    { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_lgbt_brown")$m$text$nc";   }
function lgbt_orange   { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_lgbt_orange")$m$text$nc";  }
function lgbt_yellow   { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_lgbt_yellow")$m$text$nc";  }
function lgbt_green    { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_lgbt_green")$m$text$nc";   }
function lgbt_sky      { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_lgbt_sky")$m$text$nc";     }
function lgbt_blue     { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_lgbt_blue")$m$text$nc";    }
function lgbt_purple   { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_lgbt_purple")$m$text$nc";  }
function lgbt_pink     { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_lgbt_pink")$m$text$nc";    }

function noxus_00 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_noxus_00")$m$text$nc"; }
function noxus_01 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_noxus_01")$m$text$nc"; }
function noxus_02 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_noxus_02")$m$text$nc"; }
function noxus_03 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_noxus_03")$m$text$nc"; }
function noxus_04 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_noxus_04")$m$text$nc"; }
function noxus_05 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_noxus_05")$m$text$nc"; }
function noxus_06 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_noxus_06")$m$text$nc"; }
function noxus_07 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_noxus_07")$m$text$nc"; }
function noxus_08 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_noxus_08")$m$text$nc"; }
function noxus_09 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_noxus_09")$m$text$nc"; }
function noxus_10 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_noxus_10")$m$text$nc"; }
function noxus_11 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_noxus_11")$m$text$nc"; }

function piltover_00 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_piltover_00")$m$text$nc"; }
function piltover_01 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_piltover_01")$m$text$nc"; }
function piltover_02 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_piltover_02")$m$text$nc"; }
function piltover_03 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_piltover_03")$m$text$nc"; }
function piltover_04 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_piltover_04")$m$text$nc"; }
function piltover_05 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_piltover_05")$m$text$nc"; }
function piltover_06 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_piltover_06")$m$text$nc"; }
function piltover_07 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_piltover_07")$m$text$nc"; }
function piltover_08 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_piltover_08")$m$text$nc"; }
function piltover_09 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_piltover_09")$m$text$nc"; }
function piltover_10 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_piltover_10")$m$text$nc"; }
function piltover_11 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_piltover_11")$m$text$nc"; }
function piltover_12 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_piltover_12")$m$text$nc"; }

function shurima_00 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_shurima_00")$m$text$nc"; }
function shurima_01 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_shurima_01")$m$text$nc"; }
function shurima_02 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_shurima_02")$m$text$nc"; }
function shurima_03 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_shurima_03")$m$text$nc"; }
function shurima_04 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_shurima_04")$m$text$nc"; }
function shurima_05 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_shurima_05")$m$text$nc"; }
function shurima_06 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_shurima_06")$m$text$nc"; }
function shurima_07 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_shurima_07")$m$text$nc"; }
function shurima_08 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_shurima_08")$m$text$nc"; }
function shurima_09 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_shurima_09")$m$text$nc"; }
function shurima_10 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_shurima_10")$m$text$nc"; }
function shurima_11 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_shurima_11")$m$text$nc"; }

function targon_00 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_targon_00")$m$text$nc"; }
function targon_01 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_targon_01")$m$text$nc"; }
function targon_02 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_targon_02")$m$text$nc"; }
function targon_03 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_targon_03")$m$text$nc"; }
function targon_04 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_targon_04")$m$text$nc"; }
function targon_05 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_targon_05")$m$text$nc"; }
function targon_06 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_targon_06")$m$text$nc"; }
function targon_07 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_targon_07")$m$text$nc"; }
function targon_08 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_targon_08")$m$text$nc"; }
function targon_09 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_targon_09")$m$text$nc"; }
function targon_10 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_targon_10")$m$text$nc"; }
function targon_11 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_targon_11")$m$text$nc"; }

function zaun_00 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_zaun_00")$m$text$nc"; }
function zaun_01 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_zaun_01")$m$text$nc"; }
function zaun_02 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_zaun_02")$m$text$nc"; }
function zaun_03 { param ([string]$text); return "`e[$frg;$(hex_to_rgb "$hex_zaun_03")$m$text$nc"; }

#### 🇬🇧 Dark mode
#### 🇫🇷 Mode sombre
#### 🇪🇸 Modo oscuro
#### 🇮🇹 Modalità scura
#### 🇵🇹 Modo escuro
#### 🇩🇪 Dunkler Modus
#### 🇳🇱 Donkere modus
#### 🏴󠁥󠁳󠁣󠁴󠁿 Mode fosc
#### 🇷🇴 Mod închis
#### 🇬🇷 Σκοτεινός τρόπος
#### 🇬🇪 მუქი რეჟიმი
#### 🇺🇦 Темний режим

##### 🇬🇧 For code and samp
##### 🇫🇷 Pour les codes internes
##### 🇪🇸 Para los códigos internos
##### 🇮🇹 Per i codici interni
##### 🇵🇹 Para os códigos internos
##### 🇩🇪 Für die internen Codes
##### 🇳🇱 Voor de interne codes
##### 🏴󠁥󠁳󠁣󠁴󠁿 Per als codis interns
##### 🇷🇴 Pentru codurile interne
##### 🇬🇷 Για τους εσωτερικούς κωδικούς
##### 🇬🇪 შიდა კოდებისთვის
##### 🇺🇦 Для внутрішніх кодів
function dark_code_itau_empresas_00
{
  param ([string]$text)

  $fg_colour = $(hex_to_rgb "$hex_itau_empresas_00")
  $bg_colour = $(hex_to_rgb "$hex_itau_empresas_04")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_empresas_01
{
  param ([string]$text)

  $fg_colour = $(hex_to_rgb "$hex_itau_empresas_03")
  $bg_colour = $(hex_to_rgb "$hex_itau_empresas_04")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_ion_00
{
  param ([string]$text)

  $fg_colour = $(hex_to_rgb "$hex_itau_ion_00")
  $bg_colour = $(hex_to_rgb "$hex_itau_ion_03")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_ion_01
{
  param ([string]$text)

  $fg_colour = $(hex_to_rgb "$hex_itau_ion_01")
  $bg_colour = $(hex_to_rgb "$hex_itau_ion_03")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_ion_02
{
  param ([string]$text)

  $fg_colour = $(hex_to_rgb "$hex_itau_ion_02")
  $bg_colour = $(hex_to_rgb "$hex_itau_ion_03")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_ion_03
{
  param ([string]$text)

  $fg_colour = $(hex_to_rgb "$hex_itau_ion_00")
  $bg_colour = $(hex_to_rgb "$hex_itau_ion_04")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_ion_04
{
  param ([string]$text)

  $fg_colour = $(hex_to_rgb "$hex_itau_ion_01")
  $bg_colour = $(hex_to_rgb "$hex_itau_ion_04")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_ion_05
{
  param ([string]$text)

  $fg_colour = $(hex_to_rgb "$hex_itau_ion_02")
  $bg_colour = $(hex_to_rgb "$hex_itau_ion_04")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_ion_06
{
  param ([string]$text)

  $fg_colour = $(hex_to_rgb "$hex_itau_ion_00")
  $bg_colour = $(hex_to_rgb "$hex_itau_ion_06")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_ion_07
{
  param ([string]$text)

  $fg_colour = $(hex_to_rgb "$hex_itau_ion_01")
  $bg_colour = $(hex_to_rgb "$hex_itau_ion_06")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_ion_08
{
  param ([string]$text)

  $fg_colour = $(hex_to_rgb "$hex_itau_ion_02")
  $bg_colour = $(hex_to_rgb "$hex_itau_ion_06")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_iti_00
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_itau_iti_00")
  $fg_colour = $(hex_to_rgb "$hex_itau_iti_01")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}
function dark_code_itau_iti_01
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_itau_iti_03")
  $fg_colour = $(hex_to_rgb "$hex_itau_iti_01")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_iti_02
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_itau_iti_02")
  $fg_colour = $(hex_to_rgb "$hex_itau_iti_01")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_iti_03
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_itau_iti_02")
  $fg_colour = $(hex_to_rgb "$hex_itau_iti_03")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_iti_04
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_itau_iti_04")
  $fg_colour = $(hex_to_rgb "$hex_itau_iti_01")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_iti_05
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_itau_iti_04")
  $fg_colour = $(hex_to_rgb "$hex_itau_iti_03")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_personnalite_00
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_itau_personnalite_00")
  $fg_colour = $(hex_to_rgb "$hex_itau_personnalite_02")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_personnalite_01
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_itau_personnalite_00")
  $fg_colour = $(hex_to_rgb "$hex_itau_personnalite_03")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_personnalite_02
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_itau_personnalite_00")
  $fg_colour = $(hex_to_rgb "$hex_itau_personnalite_04")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_personnalite_03
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_itau_personnalite_01")
  $fg_colour = $(hex_to_rgb "$hex_itau_personnalite_02")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_personnalite_04
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_itau_personnalite_05")
  $fg_colour = $(hex_to_rgb "$hex_itau_personnalite_02")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_personnalite_05
{
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_itau_personnalite_06")
  $fg_colour = $(hex_to_rgb "$hex_itau_personnalite_02")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_personnalite_06
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_itau_personnalite_06")
  $fg_colour = $(hex_to_rgb "$hex_itau_personnalite_03")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_personnalite_07
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_itau_personnalite_06")
  $fg_colour = $(hex_to_rgb "$hex_itau_personnalite_04")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_personnalite_08
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_itau_personnalite_07")
  $fg_colour = $(hex_to_rgb "$hex_itau_personnalite_02")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_personnalite_09
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_itau_personnalite_07")
  $fg_colour = $(hex_to_rgb "$hex_itau_personnalite_03")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_personnalite_10
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_itau_personnalite_07")
  $fg_colour = $(hex_to_rgb "$hex_itau_personnalite_04")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_personnalite_11
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_itau_personnalite_08")
  $fg_colour = $(hex_to_rgb "$hex_itau_personnalite_02")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_personnalite_12
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_itau_personnalite_08")
  $fg_colour = $(hex_to_rgb "$hex_itau_personnalite_03")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_personnalite_13
{
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_itau_personnalite_08")
  $fg_colour = $(hex_to_rgb "$hex_itau_personnalite_04")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_personnalite_14
{
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_itau_personnalite_09")
  $fg_colour = $(hex_to_rgb "$hex_itau_personnalite_02")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_personnalite_15
{
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_itau_personnalite_09")
  $fg_colour = $(hex_to_rgb "$hex_itau_personnalite_03")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_itau_personnalite_16
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_itau_personnalite_09")
  $fg_colour = $(hex_to_rgb "$hex_itau_personnalite_04")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_noxus_00
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_noxus_00")
  $fg_colour = $(hex_to_rgb "$hex_noxus_02")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_noxus_01
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_noxus_00")
  $fg_colour = $(hex_to_rgb "$hex_noxus_03")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_noxus_02
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_noxus_00")
  $fg_colour = $(hex_to_rgb "$hex_noxus_05")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_noxus_03
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_noxus_00")
  $fg_colour = $(hex_to_rgb "$hex_noxus_06")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_noxus_04
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_noxus_00")
  $fg_colour = $(hex_to_rgb "$hex_noxus_07")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_noxus_05
{
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_noxus_00")
  $fg_colour = $(hex_to_rgb "$hex_noxus_08")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_noxus_06
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_noxus_00")
  $fg_colour = $(hex_to_rgb "$hex_noxus_11")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_noxus_07
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_noxus_01")
  $fg_colour = $(hex_to_rgb "$hex_noxus_02")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_noxus_08
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_noxus_01")
  $fg_colour = $(hex_to_rgb "$hex_noxus_03")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_noxus_09
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_noxus_01")
  $fg_colour = $(hex_to_rgb "$hex_noxus_05")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_noxus_10
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_noxus_01")
  $fg_colour = $(hex_to_rgb "$hex_noxus_06")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_noxus_11
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_noxus_01")
  $fg_colour = $(hex_to_rgb "$hex_noxus_07")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_noxus_12
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_noxus_01")
  $fg_colour = $(hex_to_rgb "$hex_noxus_08")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_noxus_13
{
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_noxus_01")
  $fg_colour = $(hex_to_rgb "$hex_noxus_11")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_noxus_14
{
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_noxus_04")
  $fg_colour = $(hex_to_rgb "$hex_noxus_07")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_noxus_15
{
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_noxus_04")
  $fg_colour = $(hex_to_rgb "$hex_noxus_08")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_noxus_16
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_noxus_04")
  $fg_colour = $(hex_to_rgb "$hex_noxus_11")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_noxus_17
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_noxus_09")
  $fg_colour = $(hex_to_rgb "$hex_noxus_06")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_noxus_18
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_noxus_09")
  $fg_colour = $(hex_to_rgb "$hex_noxus_07")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_noxus_19
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_noxus_09")
  $fg_colour = $(hex_to_rgb "$hex_noxus_08")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_noxus_20
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_noxus_09")
  $fg_colour = $(hex_to_rgb "$hex_noxus_11")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_noxus_21
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_noxus_10")
  $fg_colour = $(hex_to_rgb "$hex_noxus_02")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_noxus_22
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_noxus_10")
  $fg_colour = $(hex_to_rgb "$hex_noxus_03")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_noxus_23
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_noxus_10")
  $fg_colour = $(hex_to_rgb "$hex_noxus_05")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_noxus_24
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_noxus_10")
  $fg_colour = $(hex_to_rgb "$hex_noxus_06")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_noxus_25
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_noxus_10")
  $fg_colour = $(hex_to_rgb "$hex_noxus_07")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_noxus_26
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_noxus_10")
  $fg_colour = $(hex_to_rgb "$hex_noxus_08")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_noxus_27
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_noxus_10")
  $fg_colour = $(hex_to_rgb "$hex_noxus_11")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_piltover_00
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_piltover_01")
  $fg_colour = $(hex_to_rgb "$hex_piltover_00")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_piltover_01
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_piltover_01")
  $fg_colour = $(hex_to_rgb "$hex_piltover_04")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_piltover_02
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_piltover_01")
  $fg_colour = $(hex_to_rgb "$hex_piltover_05")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_piltover_03
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_piltover_01")
  $fg_colour = $(hex_to_rgb "$hex_piltover_08")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_piltover_04
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_piltover_02")
  $fg_colour = $(hex_to_rgb "$hex_piltover_00")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_piltover_05
{
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_piltover_02")
  $fg_colour = $(hex_to_rgb "$hex_piltover_04")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_piltover_06
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_piltover_02")
  $fg_colour = $(hex_to_rgb "$hex_piltover_05")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_piltover_07
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_piltover_02")
  $fg_colour = $(hex_to_rgb "$hex_piltover_08")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_piltover_08
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_piltover_03")
  $fg_colour = $(hex_to_rgb "$hex_piltover_00")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_piltover_09
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_piltover_03")
  $fg_colour = $(hex_to_rgb "$hex_piltover_04")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_piltover_10
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_piltover_03")
  $fg_colour = $(hex_to_rgb "$hex_piltover_05")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_piltover_11
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_piltover_03")
  $fg_colour = $(hex_to_rgb "$hex_piltover_08")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_piltover_12
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_piltover_06")
  $fg_colour = $(hex_to_rgb "$hex_piltover_00")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_piltover_13
{
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_piltover_06")
  $fg_colour = $(hex_to_rgb "$hex_piltover_04")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_piltover_14
{
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_piltover_06")
  $fg_colour = $(hex_to_rgb "$hex_piltover_05")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_piltover_15
{
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_piltover_06")
  $fg_colour = $(hex_to_rgb "$hex_piltover_08")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_piltover_16
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_piltover_11")
  $fg_colour = $(hex_to_rgb "$hex_piltover_00")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_piltover_17
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_piltover_11")
  $fg_colour = $(hex_to_rgb "$hex_piltover_04")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_piltover_18
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_piltover_11")
  $fg_colour = $(hex_to_rgb "$hex_piltover_05")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_piltover_19
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_piltover_11")
  $fg_colour = $(hex_to_rgb "$hex_piltover_08")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_shurima_00
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_shurima_01")
  $fg_colour = $(hex_to_rgb "$hex_shurima_00")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_shurima_01
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_shurima_01")
  $fg_colour = $(hex_to_rgb "$hex_shurima_02")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_shurima_02
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_shurima_01")
  $fg_colour = $(hex_to_rgb "$hex_shurima_03")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_shurima_03
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_shurima_01")
  $fg_colour = $(hex_to_rgb "$hex_shurima_06")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_shurima_04
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_shurima_01")
  $fg_colour = $(hex_to_rgb "$hex_shurima_07")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_shurima_05
{
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_shurima_01")
  $fg_colour = $(hex_to_rgb "$hex_shurima_09")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_shurima_06
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_shurima_01")
  $fg_colour = $(hex_to_rgb "$hex_shurima_10")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_shurima_07
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_shurima_11")
  $fg_colour = $(hex_to_rgb "$hex_shurima_00")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_shurima_08
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_shurima_11")
  $fg_colour = $(hex_to_rgb "$hex_shurima_03")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_shurima_09
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_shurima_11")
  $fg_colour = $(hex_to_rgb "$hex_shurima_06")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_shurima_10
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_shurima_11")
  $fg_colour = $(hex_to_rgb "$hex_shurima_07")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_shurima_11
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_shurima_11")
  $fg_colour = $(hex_to_rgb "$hex_shurima_09")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_shurima_12
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_shurima_11")
  $fg_colour = $(hex_to_rgb "$hex_shurima_10")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_targon_00
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_targon_00")
  $fg_colour = $(hex_to_rgb "$hex_targon_01")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_targon_01
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_targon_00")
  $fg_colour = $(hex_to_rgb "$hex_targon_02")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_targon_02
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_targon_00")
  $fg_colour = $(hex_to_rgb "$hex_targon_08")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_targon_03
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_targon_00")
  $fg_colour = $(hex_to_rgb "$hex_targon_09")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_targon_04
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_targon_04")
  $fg_colour = $(hex_to_rgb "$hex_targon_01")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_targon_05
{
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_targon_04")
  $fg_colour = $(hex_to_rgb "$hex_targon_02")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_targon_06
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_targon_04")
  $fg_colour = $(hex_to_rgb "$hex_targon_08")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_targon_07
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_targon_04")
  $fg_colour = $(hex_to_rgb "$hex_targon_09")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_targon_08
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_targon_07")
  $fg_colour = $(hex_to_rgb "$hex_targon_01")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_targon_09
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_targon_07")
  $fg_colour = $(hex_to_rgb "$hex_targon_02")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_targon_10
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_targon_07")
  $fg_colour = $(hex_to_rgb "$hex_targon_08")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_targon_11
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_targon_07")
  $fg_colour = $(hex_to_rgb "$hex_targon_09")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_targon_12
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_targon_10")
  $fg_colour = $(hex_to_rgb "$hex_targon_01")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_targon_13
{
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_targon_10")
  $fg_colour = $(hex_to_rgb "$hex_targon_02")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_targon_14
{
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_targon_10")
  $fg_colour = $(hex_to_rgb "$hex_targon_08")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_targon_15
{
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_targon_10")
  $fg_colour = $(hex_to_rgb "$hex_targon_09")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_targon_16
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_targon_11")
  $fg_colour = $(hex_to_rgb "$hex_targon_01")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_targon_17
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_targon_11")
  $fg_colour = $(hex_to_rgb "$hex_targon_02")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_targon_18
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_targon_11")
  $fg_colour = $(hex_to_rgb "$hex_targon_08")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_targon_19
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_targon_11")
  $fg_colour = $(hex_to_rgb "$hex_targon_09")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

function dark_code_zaun_01
{ 
  param ([string]$text)

  $bg_colour = $(hex_to_rgb "$hex_zaun_01")
  $fg_colour = $(hex_to_rgb "$hex_zaun_02")
  return "`e[$bg;$bg_colour;$frg;$fg_colour$m $text $nc"
}

# negrito "The text is in bold"
# itau_empresas_01 "The text is colourful"
# itau_ion_00 "The text is colourful"
# itau_iti_02 "The text is colourful"
# itau_personnalite_00 "The text is colourful"
# lgbt_red "The text is colourful"
# noxus_02 "The text is colourful"
# piltover_05 "The text is colourful"
# piltover_07 "The text is colourful"
# shurima_02 "The text is colourful"
# targon_02 "The text is colourful"
# targon_10 "The text is colourful"
# zaun_03 "The text is colourful"
# dark_code_itau_empresas_00 "The inner code"
# Write-Host "Here is the $(dark_code_itau_empresas_00 "inner code") for the terminal."
