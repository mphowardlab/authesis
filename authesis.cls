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
\ProvidesClass{authesis}[2026/06/03 v1.0.0 Auburn University Graduate School Dissertation/Thesis]

\LoadClass[letterpaper,12pt,oneside]{report}

\RequirePackage{xkeyval}

\RequirePackage[english]{babel}
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
\ProcessOptionsX\relax

% Default formatting
\newgeometry{margin=1in}
\RequirePackage{indentfirst}
\doublespacing
\renewcommand{\familydefault}{\sfdefault}
\DeclareMathSizes{12pt}{12pt}{10pt}{8pt}
\ifragged
    \raggedright
    \setlength{\parindent}{1.5em}
\fi

% Section header styles, modified from report.cls
\def\@makechapterhead#1{%
  \vspace*{3\baselineskip}%
  {\parindent \z@ \centering \normalfont
    \ifnum \c@secnumdepth >\m@ne
        \@chapapp\space \thechapter
        \par\nobreak
    \fi
    \interlinepenalty\@M
    #1\par\nobreak
    \vskip \baselineskip
  }}
\def\@makeschapterhead#1{%
  \vspace*{3\baselineskip}%
  {\parindent \z@ \centering
    \normalfont
    \interlinepenalty\@M
    #1\par\nobreak
    \vskip \baselineskip
  }}
% chapter* in front matter has no top space
\newenvironment{frontmatter}{%
  \renewcommand{\@makeschapterhead}[1]{%
      {\parindent \z@ \centering
        \normalfont
        \interlinepenalty\@M
        ##1\par\nobreak
        \vskip \baselineskip
      }}
}{%
  \renewcommand{\@makeschapterhead}[1]{%
      \vspace*{3\baselineskip}
      {\parindent \z@ \centering
        \normalfont
        \interlinepenalty\@M
        ##1\par\nobreak
        \vskip \baselineskip
      }}
}
\renewcommand\section{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\normalfont\normalsize\raggedright}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\normalsize\raggedright}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\normalsize\raggedright}}

% Title page
\newcommand{\degreetype}[1]{\def\@degreetype{#1}}
\newcommand{\keywords}[1]{\def\@keywords{#1}}
\newcommand{\committee}[1]{\def\@committee{#1}}
\newcommand{\committeemember}[1]{\item{\hspace{-1.5em}#1}}
\ifdissertation
\def\thesistype{dissertation}
\else
\def\thesistype{thesis}
\fi
\renewcommand{\maketitle}{%
    \newgeometry{margin=1in,top=2in,bottom=1in}
    \thispagestyle{empty}
    \begin{center}
        \newpage
        \singlespacing
        \setlength{\parskip}{0pt}
        \tagstructbegin{tag=Title}
        \tagmcbegin{tag=Title}
        % Disable automatic tagging, otherwise a P gets inserted inside the Title
        \tagpdfsetup{para/tagging=false}

        {\bfseries \@title}

        \tagpdfsetup{para/tagging=true}
        \tagmcend
        \tagstructend

        \vspace{\baselineskip}

        by \par

        \vspace{\baselineskip}

        \@author\par

	\vspace{4\baselineskip}

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

        \vspace{\baselineskip}

        Auburn, Alabama \par
        \@date \par

	\vspace{4\baselineskip}

	\ifdefined\@keywords
	Keywords: \@keywords \par
	\vspace{2\baselineskip}
	\fi

	\ifcopyright
	Copyright {\the\year{}} by \@author \par
	\vspace{2\baselineskip}
	\fi

	Approved by\par
        \begin{itemize}[label={}]
                \setlength{\itemsep}{0pt}
                \setlength{\parskip}{0pt}
                \setlength{\parsep}{0pt}
                \centering
                \@committee
        \end{itemize}
    \end{center}
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

% bibliography
\RequirePackage[backend=biber, biblabel=brackets, defernumbers=true]{biblatex}
\DeclareCiteCommand{\citenum}{}{\bibhyperref{\printfield{labelnumber}}}{\multicitedelim}{}
\setlength{\bibitemsep}{\baselineskip}
\AtBeginBibliography{\singlespacing}