# Auburn University Graduate School Dissertation/Thesis Template

This repository provides a template for writing a dissertation or thesis in the
format required by the [Auburn University Graduate School][1]. Best efforts have
been made to ensure the template complies with digital accessibility
requirements.

## Requirements

This template requires an up-to-date TeX installation (minimum: TeX Live 2025).
The compiler must be LuaLaTeX, and the bibliography backend must be biber.

## Getting started

Download this template from GitHub as a ZIP file, then choose whether you would
like to write your dissertation or thesis on [Overleaf][2] or locally on your
computer. Auburn University currently provides [access to Overleaf premium][3]
for all students, faculty, and staff, so directions to get started there are:

1. Create a *New project* then choose to *Upload project* with the ZIP file you
   downloaded.
2. Open *Settings* (`File > Settings` or gear icon in lower left corner), go to
   the *Compiler* tab, then select LuaLaTeX from the list of compilers. Ensure
   the TeX Live version is set to the most current option.
3. Open [`main.tex`](./main.tex) in your Overleaf project, and click
   *Recompile* to generate a PDF.
4. [Configure your document](#configuration).
5. [Fill in your front matter](#front-matter).
6. [Write your content](#writing-the-document).
7. Defend and graduate!

> [!TIP]
> If you are working locally on your computer, ensure you have installed a
> current version of TeX Live and that you have set the compilers correctly. The
> comment lines at the top of [`main.tex`](./main.tex) are hints for some
> editors to use `lualatex` and `biber`.

## Configuration

The `authesis` class provides options for configuring your document, which you
can specify when it is loaded:

```latex
\documentclass[options]{authesis}
```

The `options` that can be added as a comma-separated list are:

- `thesis`: format the front matter for a thesis rather than a dissertation.
- `nocopyright`: disable the copyright notice on the title page.
- `ragged`: use ragged right edge, rather than justified, text. Ragged text may
  may be better for accessibility.
- `bibstyle`: a valid [bibliiography style][4] (keyword argument). Defaults to
  `phys` if not specified.
- `nohyperref`: disable hyperlinks in document.

You should then ensure you have loaded and configured the packages you need for
writing your document. There are a couple things you need to be aware of:

- You must use `unicode-math` if you are using math.
- Different graphics packages (such as `tikz` and `pgfplots` can also be used),
  but make sure you are using accessible colors.

If you would like to use other packages, you must make sure it is `compatible`
with tagging. You can check the status of a large number of packages through
the [LaTeX Tagging Project][5].

> [!TIP]
> The `fontsetup` package can slow down compilation considerably. Comment out
> the font commands while you are drafting to speedup your workflow.

## Front matter

The front matter is the preliminary pages of the dissertation or thesis,
including the title page, abstract, disclosure statements, acknowledgements,
and lists of contents.

The title page is automatically generated for you. You will need to fill in:

- `\title`: the title of your dissertation or thesis.
- `\degreetype`: name of your degree, if different from Doctor of Philosophy
  (dissertation) or Master of Science (thesis).
- `\date`: your **graduation** date. Check the [academic calendar][6] for your
  semester.
- `\keywords`: up to 6 keywords in a comma- and space-separated list
  (*optional*).
- `\committee`: ordered list of your committee members. Each `\committeemember`
  should be specified on a separate line with their title. Put your Chair and
  co-Chair (if any) first and indicate them as such.

You are also required to provide an abstract, artificial intelligence (AI) use
disclosure statement, and digital accessibility disclosure statement. Templates
for the disclosure statements are provided in the template following Graduate
School guidance. An acknowledgments section is optional but traditional.

The following lists of contents are the final component of the front matter:

1. `\tableofcontents`: List of front matter, chapters, and appendices up to the
   section depth (required).
2. `\listoftables`: List of all tables (required if tables are used).
3. `\listoffigures`: List of all figures (required if figures are used).
4. List of abbrevations of symbols: not currently supported by template.

You should comment out the `\listoftables` and `\listoffigures` if they are not
needed for your document.

## Writing the document

The contents of the dissertation or thesis are organized into chapters. The
chapters are followed by a complete list of references. There may then be
one or more appendices.

A suggested file structure is provided with this template. You create a `.tex`
file for each chapter or appendix in the appropriate directory, then use
`\input` to include that file in the main document. When using figures, create
a directory so you can keep your `.tex` file and figures together; see
[Chapter 2](./chapter/02/) for an example.

> [!TIP]
> You can set the `\graphicspath` (relative to the root of the project) at the
> start of a `.tex` file so that graphics can be included relative to the
> chapter directory. Make sure to do this for each chapter if you use it!

You may find it helpful to prepend chapter or appendix numbers to labels in your
`.tex` files to avoid conflicts between chapters, especially if some of your
chapters were published as articles. For example:

```latex
\label{ch1:eq:msd}
\label{appB:fig:diffusion}
```

References will be placed in brackets where they appear, so may sure you put
your `\cite` commands in the right place. For example:

```latex
Einstein's foundational work on Brownian motion began with a paper in
1905 \cite{einstein:1905} that is part of a collection of papers published as a
book \cite{einstein:1926, einstein:1956}.
```

Example chapters are provided to illustrate different concepts and TeX commands,
so searching this is a good starting point if you are unsure how to write
something. Stylewise, be sure to follow the conventions of your discipline!

## Best practices for digital accessibility

- Use chapters, sections, and subsections to organize text.
- Avoid placement specifiers for figures and tables.
- Provide alternative text for all figures. An example template for a figure is:

  ```latex
  \begin{figure}
    \centering
    \includegraphics[alt={Alt text}]{image}
    \caption[Optional short title to appear in list of figures]{Caption}
    \label{fig:image}
  \end{figure}
  ```

- Specify the headers in your tables using `\tagpdfsetup`. An example for a
  table where the first row is the header:

  ```latex
  \begin{table}
    \centering
    \caption[Optional short title to appear in list of tables]{Caption}
    \tagpdfsetup{table/header-rows={1}}
    \begin{tabular}{|l|l|}
        \hline
        \textbf{Header 1} & \textbf{Header 2} \\
        \hline
        Data 1 & Data 2 \\
        \hline
    \end{tabular}
  \end{table}
  ```

  If you also have header columns, you can specify them like:
  
  ```latex
  \tagpdfsetup{table/header-columns={1},table/header-rows={1}}
  ```
  
  Use multirow and multicolumn layouts in tables with caution. It *may* be
  possible to use the `multirow` package if you load `array` [first][7].

## Validation

There are currently no perfect tools for testing PDFs for digital accessibility.
This template is tested using [veraPDF][8], an industry-supported, open-source
tool. You can [download veraPDF from its website][9], or you can install it via
`conda-forge`:

```bash
conda install -c conda-forge verapdf
```

> [!TIP]
> If you are installing by conda on a Mac computer with Apple silicon, you will
> need to configure your environment for x86_64 because the feedstock does not
> currently support ARM-based processors.
>
> ```bash
> conda config --env --set subdir osx-64
> ```

Once installed, you can validate your compiled document for PDF/UA-2:

```bash
verapdf -f ua2 --format html main.pdf > verapdf-ua-2.html
```

To test against [Web Content Accessibility Guidelines (WCAG) 2.2][10],
first [download the veraPDF validation profiles][11] and and extract them to
`veraPDF-validation-profiles`. Then,

```bash
verapdf --profile veraPDF-validation-profiles/PDF_UA/WCAG-2-2-Complete-PDF20.xml \
    --format html main.pdf > verapdf-wcag-2.2.html
```

Review the reports and address any issues! Please note, though, that some
aspects of compliance may still need to be checked manually.

> [!WARNING]
> The [PDF Accessibility Checker (PAC)][12] is another commonly used validator;
> however, it may currently interpret elements of PDF 2.0 files, which is the
> file format for this template, as errors.

## License and credits

This template is made available under an [MIT License](./LICENSE). It was
adapted from [uiucthesis][13] under its license:

```
MIT License

Copyright (c) 2026 Graduate College

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

[1]: https://graduate.auburn.edu/current-students/academic-resources/etd.php
[2]: https://www.overleaf.com
[3]: https://www.overleaf.com/edu/auburn
[4]: https://www.overleaf.com/learn/latex/Bibtex_bibliography_styles
[5]: https://latex3.github.io/tagging-project/tagging-status
[6]: https://auburn.edu/about/academic-calendar
[7]: https://github.com/graduatecollege/uofithesis/issues/6#issuecomment-4057268158
[8]: https://verapdf.org
[9]: https://docs.verapdf.org/install
[10]: https://www.w3.org/TR/WCAG22
[11]: http://github.com/veraPDF/veraPDF-validation-profiles
[12]: https://pac.pdf-accessibility.org
[13]: https://github.com/graduatecollege/uofithesis
