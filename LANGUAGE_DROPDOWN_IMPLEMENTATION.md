# Language Dropdown Implementation for Image Classification

## Overview
A language dropdown has been added to the image classification page that allows users to select their preferred language for the API response.

## Features Added

### 1. Language Dropdown UI
- **Location**: `lib/features/home/image_classification/ui/widgets/choose_image.dart`
- **Position**: Between the main image and the upload button
- **Styling**: Matches the existing design with rounded corners and border

### 2. Supported Languages
The dropdown includes the following languages with their corresponding ISO codes:

| Display Name | Language Code |
|--------------|---------------|
| English      | en            |
| Spanish      | es            |
| French       | fr            |
| Arabic       | ar            |
| German       | de            |
| Chinese      | zh            |
| Japanese     | ja            |

### 3. Implementation Details

#### Controller Changes (`image_classifier.dart`)
- Added `selectedLanguage` property (defaults to 'en')
- Added `setLanguage(String languageCode)` method
- Modified `chatBot()` method to pass language parameter to repository

#### Repository Changes (`image_classiy_repo.dart`)
- Updated `chatBot()` method signature to accept language parameter
- Added `"lang": language` to the FormData sent to the API

#### UI Changes (`choose_image.dart`)
- Added language dropdown with all supported languages
- Added `_selectedLanguage` state variable
- Added `_languages` map for language name to code mapping
- Added `initState()` to initialize default language
- Added dropdown change handler to update controller

### 4. API Integration
The language parameter is sent to the `/cnn_model/` endpoint as:
```dart
FormData.fromMap({
  "file": await MultipartFile.fromFile(resizedFile.path),
  "lang": language, // e.g., "en", "es", "fr", etc.
})
```

**FastAPI Endpoint Response:**
```json
{
  "king_name": "King Name",
  "description": "Description",
  "video_path": "Video URL"
}
```

### 5. User Experience
- **Default Language**: English (en)
- **Visual Feedback**: Dropdown shows full language names
- **Backend Communication**: Sends ISO language codes
- **State Management**: Language selection persists during the session

## Technical Notes
- The language dropdown is positioned above the upload button for better UX
- Language selection is immediately synchronized with the controller
- The implementation follows the existing code patterns and styling
- Error handling remains unchanged and works with the new language parameter

## Testing
To test the implementation:
1. Navigate to the image classification screen
2. Select a language from the dropdown
3. Upload an image
4. Verify that the selected language code is sent in the API request
5. Check that the response is in the selected language (if supported by the backend) 