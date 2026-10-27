#!/usr/bin/env pwsh

# 🇬🇧 Translations
# 🇫🇷 Traductions
# 🇮🇹 Traduzioni
# 🇪🇸 Traducciones
# 🇵🇹 Traduções
# 🇩🇪 Übersetzen
# 🇳🇱 Vertalingen
# 🏴󠁥󠁳󠁣󠁴󠁿 Traduccions
# 🇷🇴 Traduceri
# 🇬🇷 Μεταφράσεις
# 🇬🇪 თარგმანები
# 🇺🇦 Переклади

# 🇬🇧 Getting the LANG environment variable
# 🇫🇷 Récupérer la variable d’environnement de LANG
# 🇪🇸 Obtener la variable de entorno de LANG
# 🇮🇹 Ottenere la variabile d’ambiente di LANG
# 🇵🇹 Obter a variável de ambiente de LANG
# 🇩🇪 Die LANG-Umgebungsvariable abrufen
# 🇳🇱 De LANG-omgevingsvariabele ophalen
# 🏴󠁥󠁳󠁣󠁴󠁿 Obtenir la variable d’entorn LANG
# 🇷🇴 Obținerea variabilei de mediu LANG
# 🇬🇷 Λαμβάνοντας τη μεταβλητή περιβάλλοντος LANG
# 🇬🇪 LANG გარემოს ცვლადის მიღება
# 🇺🇦 Отримання змінної середовища LANG

## 🇬🇧 Extracting the language and country codes
## 🇫🇷 Extraction des codes de langue et de pays
## 🇪🇸 Extrayendo los códigos de idioma y país
## 🇮🇹 Estraendo i codici di lingua e paese
## 🇵🇹 Extraindo os códigos de língua e país
## 🇩🇪 Der Sprach- und Ländercodes extrahieren
## 🇳🇱 Taal- en landcodes extraheren
## 🏴󠁥󠁳󠁣󠁴󠁿 Extracció dels codis de llengua i país
## 🇷🇴 Extracția codurilor de limbă și țară
## 🇬🇷 Εξαγωγή των κωδικών γλώσσας και χώρας
## 🇬🇪 ენისა და ქვეყნის კოდების ამოღება
## 🇺🇦 Витягування кодів мови та країни

### 🇬🇧 First two characters for language code
### 🇫🇷 Les deux premiers caractères pour le code de langue
### 🇪🇸 Los dos primeros caracteres para el código de idioma
### 🇮🇹 I primi due caratteri per il codice della lingua
### 🇵🇹 Os dois primeiros caracteres para o código da língua
### 🇩🇪 Die ersten beiden Zeichen für den Sprachcode
### 🇳🇱 De eerste twee tekens voor de taalcodes
### 🏴󠁥󠁳󠁣󠁴󠁿 Primeres dues lletres per al codi de llengua
### 🇷🇴 Primele două caractere pentru codul de limbă
### 🇬🇷 Οι πρώτοι δύο χαρακτήρες για τον κωδικό γλώσσας
### 🇬🇪 ენის კოდის პირველი ორი სიმბოლო
### 🇺🇦 Перші два символи для коду мови
$langCode = $env:LANG.Substring(0, 2) 
### 🇬🇧 Next two characters for country code, if present
### 🇫🇷 Deux caractères suivants pour le code du pays, le cas échéant
### 🇪🇸 Los siguientes dos caracteres para el código de país, si están presentes
### 🇮🇹 I successivi due caratteri per il codice del paese, se presenti
### 🇵🇹 Os próximos dois caracteres para o código do país, se presentes
### 🇩🇪 Die nächsten beiden Zeichen für den Ländercode, falls vorhanden
### 🇳🇱 De volgende twee tekens voor de landcode, indien aanwezig
### 🏴󠁥󠁳󠁣󠁴󠁿 Els següents dos caràcters per al codi del país, si estan presents
### 🇷🇴 Următoarele două caractere pentru codul de țară, dacă sunt prezente
### 🇬🇷 Οι επόμενοι δύο χαρακτήρες για τον κωδικό χώρας, αν υπάρχουν
### 🇬🇪 ქვეყნის კოდის შემდეგი ორი სიმბოლო, თუ არსებობს
### 🇺🇦 Наступні два символи для коду країни, якщо присутні
$countryCode = if ($env:LANG.Length -gt 2) { $env:LANG.Substring(3, 2) } else { "" }

# 🇬🇧 Using the `switch` statement to set the `ethernet_down_label` variable based on `langCode` and `countryCode` variables
# 🇫🇷 Utilisation de la déclaration `switch` pour définir la variable `ethernet_down_label` en fonction des variables `langCode` et `countryCode`
# 🇪🇸 Usando la declaración `switch` para establecer la variable `ethernet_down_label` en función de las variables `langCode` y `countryCode`
# 🇮🇹 Utilizzando l’istruzione `switch` per impostare la variabile `ethernet_down_label` in base alle variabili `langCode` e `countryCode`
# 🇵🇹 Usando a instrução `switch` para definir a variável `ethernet_down_label` com base nas variáveis `langCode` e `countryCode`
# 🇩🇪 Verwendung der `switch`-Anweisung zum Setzen der Variablen `ethernet_down_label` basierend auf den Variablen `langCode` und `countryCode`
# 🇳🇱 De `switch`-instructie gebruiken om de variabele `ethernet_down_label` in te stellen op basis van de variabelen `langCode` en `countryCode`
# 🏴󠁥󠁳󠁣󠁴󠁿 Utilitzant l’instrucció `switch` per establir la variable `ethernet_down_label` en funció de les variables `langCode` i `countryCode`
# 🇷🇴 Folosind instrucțiunea `switch` pentru a seta variabila `ethernet_down_label` pe baza variabilelor `langCode` și `countryCode`
# 🇬🇷 Χρησιμοποιώντας τη δήλωση `switch` για να ορίσετε τη μεταβλητή `ethernet_down_label` με βάση τις μεταβλητές `langCode` και `countryCode`
# 🇬🇪 `switch` განცხადების გამოყენება `langCode` და `countryCode` ცვლადების საფუძველზე `ethernet_down_label` ცვლადის დასადგენად
# 🇺🇦 Використання оператора `switch` для встановлення змінної `ethernet_down_label` на основі змінних `langCode` та `countryCode`
switch ($langCode) 
{
  "ca"
  {
    $cannot_extract_error = "no es pot extreure mitjançant la funció ex()"
    $invalid_format_error = "no és un fitxer vàlid"
    $ethernet_up_label = "Excel·lent"
    $ethernet_lower_up_label = "Regular"
    $ethernet_down_label = "Dolent"
  }
  "de"
  {
    $cannot_extract_error = "kann nicht über die Funktion ex() extrahiert werden"
    $invalid_format_error = "ist keine gültige Datei"
    $ethernet_up_label = "Großartig"
    $ethernet_lower_up_label = "Regelmäßig"
    $ethernet_down_label = "Schlecht"
  }
  "el"
  {
    $cannot_extract_error = "δεν μπορεί να εξαχθεί μέσω της συνάρτησης ex()"
    $invalid_format_error = "δεν είναι έγκυρο αρχείο"
    $ethernet_up_label = "Υπέροχο"
    $ethernet_lower_up_label = "Κανονικό"
  }
  "es"
  {
    $cannot_extract_error = "no se puede extraer el archivo via la función ex()"
    $invalid_format_error = "no es un formato válido"
    $ethernet_up_label = "Excelente"
    $ethernet_lower_up_label = "Bueno"
    $ethernet_down_label = "Malo"
  }
  "fr"
  {
    $cannot_extract_error = "ne peut pas être extrait via la fonction ex()"
    $invalid_format_error = "n’est pas un fichier valide"
    $ethernet_up_label = "Super"
    $ethernet_lower_up_label = "Régulier"
    $ethernet_down_label = "Mauvais"
  }
  "it"
  {
    $cannot_extract_error = "non può essere estratto tramite la funzione ex()"
    $invalid_format_error = "non è un file valido"
    $ethernet_up_label = "Ottimo"
    $ethernet_lower_up_label = "Regolare"
    $ethernet_down_label = "Cattivo"
  }
  "ka"
  {
    $cannot_extract_error = "არ შეიძლება ამოღება ფუნქციის ex() საშუალებით"
    $invalid_format_error = "არ არის ვალიდური ფაილი"
    $ethernet_up_label = "შესანიშნავი"
    $ethernet_lower_up_label = "რეგულარული"
    $ethernet_down_label = "ცუდი"
  }
  "nl"
  {
    $cannot_extract_error = "kan niet worden geëxtraheerd via de functie ex()"
    $invalid_format_error = "is geen geldig bestand"
    $ethernet_up_label = "Geweldig"
    $ethernet_lower_up_label = "Regulier"
    $ethernet_down_label = "Slecht"
  }
  "pt"
  {
    if ($countryCode -eq "BR")
    {
      $cannot_extract_error = "não pode ser extraído via a função ex()"
      $invalid_format_error = "não é um arquivo válido"
      $ethernet_up_label = "Ótimo"
      $ethernet_lower_up_label = "Regular"
      $ethernet_down_label = "Ruim"
    }
    else
    {
      $cannot_extract_error = "não pode ser extraído via a função ex()"
      $invalid_format_error = "não é um ficheiro válido"
      $ethernet_up_label = "Ótimo"
      $ethernet_lower_up_label = "Regular"
      $ethernet_down_label = "Mau"
    }
  }
  # 🇬🇧 Assuming default English
  # 🇫🇷 Supposons l’anglais par défaut
  # 🇪🇸 Suponiendo inglés por defecto
  # 🇮🇹 Assumendo l’inglese predefinito
  # 🇵🇹 A assumir ou supôr o inglês padrão
  # 🇩🇪 Standard-Englisch annehmen
  # 🇳🇱 Standaard Engels aannemen
  # 🏴󠁥󠁳󠁣󠁴󠁿 Suposant anglès per defecte
  # 🇷🇴 Presupunând engleza implicit
  # 🇬🇷 Υποθέτοντας την προεπιλεγμένη αγγλική
  # 🇬🇪 ინგლისური როგორც დეფოლტი
  # 🇺🇦 Припускаючи англійську за замовчуванням
  default
  {
    $cannot_extract_error = "cannot be extracted via the ex() function"
    $invalid_format_error = "is not a valid file"
    $ethernet_up_label = "Great"
    $ethernet_lower_up_label = "Regular"
    $ethernet_down_label = "Bad"
  }
}