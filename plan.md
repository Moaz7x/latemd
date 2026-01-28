
---

# **Project Plan: Hybrid Flutter + Web App Notes System**

---

## **Phase 0 – Prep & Research**

**Goal:** Understand the tools, technologies, and requirements before building.

1. **A. Define Scope & Features**

   * Decide what NotebookLM outputs need to include: text, mnemonics, visuals (Vega, Mermaid, TikZ, chemfig, circuits).
   * Decide app features: offline mode, lesson list, export, editing.

2. **B. Choose Tech Stack**

   * Flutter for mobile/desktop app.
   * Web app: HTML + JS + libraries (Vega-lite, Mermaid, KaTeX/TikZ renderer, ChemDoodle.js or similar).
   * Local DB: Hive or SQFlite for Flutter.

3. **C. Explore NotebookLM Customization**

   * Finalize custom prompt for generating lessons.
   * Decide output format: JSON or HTML with code blocks for visuals.

---

## **Phase 1 – NotebookLM Output Customization**

**Goal:** Produce predictable structured output for the web app to consume.

4. **D. Define JSON Schema**

   * Example fields:

     ```json
     {
       "title": "",
       "intro": "",
       "units": [
         {
           "title": "",
           "text": "",
           "mnemonic": "",
           "mnemonic_story": "",
           "visuals": [
             {"type": "vega-lite", "data": {}, "options": {}},
             {"type": "tikz", "code": ""},
             {"type": "mermaid", "code": ""}
           ]
         }
       ],
       "mindmap": ""
     }
     ```

5. **E. Test Output Generation**

   * Generate several lessons in JSON format.
   * Verify all visuals have correct code blocks and mnemonics are included.

6. **F. Build Parser Prototype (Optional)**

   * Quickly test a script that reads the JSON and logs each unit and visual to confirm everything is structured correctly.

---

## **Phase 2 – Web App Development**

**Goal:** Web app can read NotebookLM output and render lessons + visuals.

7. **G. Set Up Web App Skeleton**

   * HTML + JS environment (can be React, Vue, or vanilla JS).
   * Create placeholder lesson viewer.

8. **H. Implement Lesson Renderer**

   * Render text + mnemonics.
   * Render **Vega-lite** charts.
   * Render **Mermaid** mindmaps.
   * Render **TikZ / circuitikz** → using JS-to-SVG compiler or external service.
   * Render **Chemfig / Chemistry diagrams** → using ChemDoodle.js or similar.

9. **I. Implement Export Functions**

   * Export full lesson as JSON to Flutter.
   * Optional: Export PDFs or images for offline viewing.

10. **J. Implement JS ↔ Flutter Bridge**

    * Functions to send lesson data to Flutter when saved.
    * Functions to receive lesson data from Flutter to prefill the editor.

---

## **Phase 3 – Flutter App Development**

**Goal:** Flutter app becomes container + offline storage + offline viewer.

11. **K. Set Up Flutter Project**

    * Scaffold basic Flutter app: screens, navigation, theme.
    * Add WebView dependency.

12. **L. Embed Web App in WebView**

    * Load the local web app files in WebView.
    * Test rendering basic lesson JSON.

13. **M. Implement Local Database**

    * Decide on Hive or SQFlite.
    * Store lessons, visuals, and optional PDFs/images.

14. **N. Implement Offline Mode**

    * On app launch, list lessons from local DB.
    * Allow opening lessons even if WebView cannot fetch from network.

15. **O. Implement Lesson Sync**

    * When WebView sends lesson JSON → save to local DB.
    * When opening WebView → prefill lesson with DB content.

---

## **Phase 4 – Testing & Optimization**

**Goal:** Ensure everything works offline, visuals render correctly, and the app is stable.

16. **P. Test WebView Rendering**

    * Check all Vega, Mermaid, TikZ, Chemfig visuals.

17. **Q. Test Offline Access**

    * Remove network → lessons still open and render correctly.

18. **R. Test Export/Import**

    * Save lessons → reopen → confirm data integrity.

19. **S. Performance Optimization**

    * Lazy-load visuals if needed.
    * Cache pre-rendered diagrams to avoid re-rendering heavy TikZ or Chemfig.

---

## **Phase 5 – Polish & Release**

**Goal:** Prepare app for real-world use.

20. **T. User Interface Polish**

    * Lesson list, search, filters.
    * Smooth WebView interactions.

21. **U. Optional Features**

    * PDF export of lessons.
    * Share lessons between devices.
    * Dark mode / theme customization.

22. **V. Packaging & Distribution**

    * Build APK (Flutter) with embedded web app.
    * Test on Android/iOS (if desired).

---

✅ **Summary Workflow**

```
NotebookLM → JSON → Web App (renders visuals + text) → Flutter WebView (container + DB) → Offline storage + viewer
```

---
