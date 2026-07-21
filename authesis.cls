%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This file is modified from uofithesis.cls released under:
%
% MIT License
%
% Copyright (c) 2026 Graduate College
%
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}[2025/11/01]
\ProvidesClass{authesis}[2026/07/16 v1.1.0 Auburn University Graduate School Dissertation/Thesis]

\LoadClass[letterpaper,12pt,oneside]{report}

\RequirePackage{xkeyval}

\RequirePackage[english]{babel}
\RequirePackage{csquotes}
\RequirePackage{geometry}
\RequirePackage{setspace}
\RequirePackage{float}

% Class options
% Dissertation (default) or thesis
\newif\ifdissertation
\dissertationtrue
\DeclareOptionX{thesis}{\dissertationfalse}
% Whether to print copyright notice
\newif\ifcopyright
\copyrighttrue
\DeclareOptionX{nocopyright}{\copyrightfalse}
% Whether to make the text ragged
\newif\ifragged
\raggedfalse
\DeclareOptionX{ragged}{\raggedtrue}
% Bibliography style
\PassOptionsToPackage{style=phys}{biblatex}
\DeclareOptionX{bibstyle}[phys]{
    \PassOptionsToPackage{style=#1}{biblatex}
}
% Hyperlinks
\newif\ifusehyperref
\usehyperreftrue
\DeclareOptionX{nohyperref}{\usehyperreffalse}
\ProcessOptionsX\relax

% Default formatting
\newgeometry{margin=1in}
\RequirePackage{indentfirst}
\doublespacing
\renewcommand{\familydefault}{\sfdefault}
\DeclareMathSizes{12pt}{12pt}{10pt}{10pt}
\DeclareMathSizes{10pt}{10pt}{10pt}{10pt}
\ifragged
    \raggedright
    \setlength{\parindent}{1.5em}
\fi

% quote formatting
\AtBeginEnvironment{quote}{\singlespacing}
\AtBeginEnvironment{quotation}{\singlespacing}
\AtBeginEnvironment{verbatim}{\singlespacing}

% hyperlink formatting
\usepackage{xcolor}
\definecolor{hyperrefblue}{HTML}{3333ff}
\RequirePackage[pdfusetitle]{hyperref}
\hypersetup{
  bookmarksnumbered,
  colorlinks=true,
  allcolors=hyperrefblue,
  linktoc=page
}
\ifusehyperref\else
\hypersetup{draft}
\fi
\urlstyle{same}

% Section header styles, modified from report.cls
\def\@makechapterhead#1{%
  {\parindent \z@ \centering \normalfont
    \ifnum \c@secnumdepth >\m@ne
        \@chapapp\space \thechapter
        \par\nobreak
    \fi
    \interlinepenalty\@M
    {\singlespacing #1\par\nobreak}
    \vskip \baselineskip
  }}
\def\@makeschapterhead#1{%
  {\parindent \z@ \centering \normalfont
    \interlinepenalty\@M
    {\singlespacing #1\par\nobreak}
    \vskip \baselineskip
  }}
% chapter* in front matter has no top space
\newenvironment{frontmatter}{%
}{%
}
\renewcommand\section{\@startsection{section}{1}{\z@}%
    {-3.5ex \@plus -1ex \@minus -.2ex}%
    {2.3ex \@plus.2ex}%
    {\raggedright \singlespacing \normalfont \normalsize}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
    {-3.25ex\@plus -1ex \@minus -.2ex}%
    {1.5ex \@plus .2ex}%
    {\raggedright \singlespacing \normalfont \normalsize}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
    {-3.25ex\@plus -1ex \@minus -.2ex}%
    {1.5ex \@plus .2ex}%
    {\raggedright \singlespacing \normalfont \normalsize}}

% Title page
\newcommand{\degreetype}[1]{\def\@degreetype{#1}}
\newcommand{\keywords}[1]{\def\@keywords{#1}}
\newcommand{\committee}[1]{\def\@committee{#1}}
\newcommand{\committeemember}[1]{\item\parbox[t]{\textwidth}{\centering #1}}
\ifdissertation
\def\thesistype{dissertation}
\else
\def\thesistype{thesis}
\fi
\renewcommand{\maketitle}{%
    \newgeometry{margin=1in,top=2in,bottom=1in}
    \thispagestyle{empty}
    \begin{singlespace}
        \begin{center}
        \setlength{\parskip}{0pt}
        \tagstructbegin{tag=Title}
        \tagmcbegin{tag=Title}
        % Disable automatic tagging, otherwise a P gets inserted inside the Title
        \tagpdfsetup{para/tagging=false}

        {\bfseries \@title}

        \tagpdfsetup{para/tagging=true}
        \tagmcend
        \tagstructend
        %
        \vspace{\baselineskip}
        %
        by \par
        %
        \vspace{\baselineskip}
        %
        \@author\par
        %
        \vspace{4\baselineskip}
        %
        % Handle default degree type
        \ifdefined\@degreetype
        \def\@@degreetype{\@degreetype}
        \else
        \ifdissertation
        \def\@@degreetype{Doctor of Philosophy}
        \else
        \def\@@degreetype{Master of Science}
        \fi
        \fi
        %
        A {\thesistype} submitted to the Graduate Faculty of\\
        Auburn University\\
        in partial fulfillment of the\\
        requirements for the Degree of\\
        \@@degreetype \par
        %
        \vspace{\baselineskip}
        %
        Auburn, Alabama \par
        \@date \par
        %
        \vspace{4\baselineskip}
        %
        \ifdefined\@keywords
        Keywords: \@keywords \par
        \vspace{2\baselineskip}
        \fi
        %
        \ifcopyright
        Copyright {\the\year{}} by \@author \par
        \vspace{2\baselineskip}
        \fi
        %
        Approved by\par
        \end{center}
        \begin{list}{}{\leftmargin=0em \itemsep=0pt}
            \sloppy
            \setlength{\parskip}{0pt}
            \@committee
        \end{list}
    \end{singlespace}
    \restoregeometry
}

% Abstract
\renewenvironment{abstract}{%
    \chapter*{Abstract}
    \addcontentsline{toc}{chapter}{Abstract}
}{%
}

% AI disclosure
\newenvironment{aidisclosure}{%
    \chapter*{Artificial Intelligence (AI) Use Disclosure Statement}
    \addcontentsline{toc}{chapter}{Artificial Intelligence (AI) Use Disclosure Statement}
}{%
}

% Accessibility disclosure
\newenvironment{accessibilitydisclosure}{%
    \chapter*{Digital Accessibility Disclosure Statement}
    \addcontentsline{toc}{chapter}{Digital Accessibility Disclosure Statement}
}{%
}

% Acknowledgements
\newenvironment{acknowledgements}{%
    \chapter*{Acknowledgements}
    \addcontentsline{toc}{chapter}{Acknowledgements}
}{%
}

% Table of contents
\RequirePackage{tocbibind}
\addto\captionsenglish{%
\renewcommand{\contentsname}{Table of Contents}
}
\AtBeginDocument{\setcounter{tocdepth}{1}}
\renewcommand*{\l@chapter}{\@dottedtocline{0}{0em}{1.5em}}
\renewcommand*{\l@section}{\@dottedtocline{1}{1.5em}{2.5em}}
\renewcommand*{\l@figure}{\@dottedtocline{0}{0em}{2.5em}}
\renewcommand*{\l@table}{\@dottedtocline{0}{0em}{2.5em}}

% list of abbreviations or symbols
\newenvironment{listofnomenclature}[1][Abbreviations]{%
\chapter*{List of #1}
\addcontentsline{toc}{chapter}{List of #1}
\vspace{\topskip}
\begin{flushleft}
\tagpdfsetup{table/tagging=presentation}
\begin{tabular}{ll}
}{%
\end{tabular}
\end{flushleft}
}

% bibliography
\RequirePackage[backend=biber, biblabel=brackets, defernumbers=true]{biblatex}
\DeclareCiteCommand{\citenum}{}{\bibhyperref{\printfield{labelnumber}}}{\multicitedelim}{}
\setlength{\bibitemsep}{\baselineskip}
\AtBeginBibliography{\singlespacing}
