% The nocopyright option turns off the copy right notice.
\newif\ifucsd@copyright \ucsd@copyrighttrue
\PassOptionsToClass{oneside,onecolumn,titlepage,letterpaper}{book}
\DeclareOption{nocopyright}{\ucsd@copyrightfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax 
\LoadClass{book}
\RequirePackage{fixltx2e}
\RequirePackage{calc}
\RequirePackage[layout=letterpaper,
	headsep=.5truein,
	footskip=.5truein,
	nomarginpar]{geometry}
\RequirePackage{setspace}
\RequirePackage{indentfirst}
\RequirePackage{tocloft}
\RequirePackage[pagestyles]{titlesec}
\RequirePackage{caption}
\RequirePackage{afterpage}
\RequirePackage{etoolbox}
\RequirePackage{ragged2e}

% This command can be used in the preamble to increase the margins
% uniformly. If uniformity is not desired, then \geometry can be used
% explicitly.
\newcommand*\increasemargins[1]{%
	\geometry{%
		top=#1+1truein,%
		bottom=#1+1truein,%
		left=#1+1truein,%
		right=#1+1truein%
	}%
}
\increasemargins{\z@} % Set the margins at the minimal size

% Title page, acknowledgment, and dissertation abstract skips
\newskip\titleskip		\titleskip=.3333in
\newskip\satisfactionskip	\satisfactionskip=.3333in
\newskip\inskip			\inskip=.6667in
\newskip\degreeskip		\degreeskip=.6667in
\newskip\byskip			\byskip=.6in
\newskip\authorskip		\authorskip=.5in
\newskip\committeeskip		\committeeskip=\z@\@plus1fill
\newskip\yearskip		\yearskip=\z@\@plus.75fill
\newskip\dissertationabstractskip \dissertationabstractskip=.3333in
\advance\committeeskip\baselineskip
\advance\yearskip\baselineskip

% \Vspace behaves like \vspace* except at the beginning of the page
% where it will actually skip the amount specified in the argument as
% opposed to the amount in the argument + \topskip
\newskip\Vspace@topskip
\providecommand\Vspace[1]{%
	\Vspace@topskip\topskip
	\topskip\z@skip
	\ifvmode
		\dimen@\prevdepth
		\hrule\@height\z@
		\nobreak
		\vskip#1%
		\vskip\z@skip
		\prevdepth\dimen@
	\else
		\@bsphack
		\vadjust{%
			\@restorepar
			\hrule\@height\z@
			\nobreak
			\vskip#1%
			\vskip\z@skip
		}%
		\@esphack
	\fi
	\topskip\Vspace@topskip
}

% Set up page numbers
\newpagestyle{body}{\sethead{}{}{} \setfoot{}{\thepage}{}}
\newpagestyle{facingcaption}{%
	\sethead{}{}{}%
	\setfoot{}{\thepage}{}%
	\oddsidemargin\dimexpr\paperwidth-\oddsidemargin-\textwidth-2in\relax
	\evensidemargin\oddsidemargin
	\@themargin\oddsidemargin
}


\assignpagestyle\chapter{plain}

\renewcommand\maketitle{%
	\begin{titlepage}
	\setsinglespacing
	\parskip=\z@
	\begingroup
		\centering
		UNIVERSITY OF CALIFORNIA SAN DIEGO\par
		\vskip\titleskip
		\@title
		\vskip\satisfactionskip
		A dissertation submitted in partial satisfaction of
		the\par requirements for the degree of \@shortdegree
		\par
		\vskip\inskip
		in\par
		\vskip\degreeskip
		\@degree\par
		\vskip\byskip
		by\par
		\vskip\authorskip
		\@author\par
	\endgroup
	\vskip\committeeskip
	\noindent Committee in charge:\par
	\vskip\baselineskip
	\@chair
	\@cochair
	\@committee
	\vskip\yearskip
	\begingroup
		\centering
		\@degreeyear\par
	\endgroup
	\vskip\baselineskip
	\end{titlepage}
	\setcounter{page}{2}%
}

\newcommand*\makecopyright{%
	\newpage
	\csuse{phantomsection}%
	\thispagestyle{empty}
	\Vspace\z@skip
	\vfill
	\ifucsd@copyright
	\begingroup
		\centering
		Copyright\par
		\@author, \@degreeyear\par
		All rights reserved.\par
		\null
	\endgroup
	\fi
	\newpage
}

% XXX: The example document has wider margins here, why??
\newcommand*\makesignature{%
	\ifx\@chair\@empty
		\ifx\@cochair\@empty
			\ClassError{ucsddissertation}{You must specify
				a \protect\chair}{Use \protect\chair}%
		\fi
	\fi
	\newpage
	\csuse{phantomsection}%
	\addcontentsline{toc}{chapter}{Signature Page}
	\Vspace\z@skip
	\vfill
	\noindent
	\hskip.5in
	\parbox{\linewidth-1in}{%
		\noindent The Dissertation of \@author\ is approved and is
		acceptable in quality and form for publication on microfilm
		and electronically:\par
		\centering
		\long\def\drawlines##1\par##2\enddrawlines{%
			\vskip.5in\hrule depth.8\p@
			\vskip3\p@\hfill
			\linelabel\par
			\ifx\relax##2\relax
			\else\drawlines##2\enddrawlines\fi}%
		\def\linelabel{\vphantom{Co-Chair}}%
		\expandafter\drawlines\@committee\enddrawlines
		\ifx\@cochair\@empty\else
			\def\linelabel{Co-Chair}%
			\expandafter\drawlines\@cochair\enddrawlines
		\fi
		\ifx\@chair\@empty\else
			\def\linelabel{Chair}%
			\expandafter\drawlines\@chair\enddrawlines
		\fi
		
		\vskip\baselineskip
		University of California San Diego\par
		\@degreeyear
	}
	\vfill
	\newpage
}

% More user commands
\newcommand\degree[2]{\gdef\@degree{#1}\gdef\@shortdegree{#2}}
\newcommand*\degreeyear[1]{\gdef\@degreeyear{#1}}
\newcommand*\chair[1]{\gdef\@chair{#1, Chair\par}}
\newcommand*\cochair[1]{%
	\expandafter\gdef\expandafter\@cochair\expandafter{\@cochair#1,
	Co-Chair\par}}
\newcommand*\committee[1]{\ifx\@committee\@empty\gdef\@committee{#1\par}\else
	\expandafter\gdef\expandafter\@committee\expandafter{\@committee#1\par}\fi}
% This is identical to \singlespacing except for the vertical space it
% adds afterward.
\newcommand*\setsinglespacing{\setstretch{\setspace@singlespace}}

\def\@degree{\ClassError{ucsddissertation}{You must specify a
\protect\degree}{Use \protect\degree}}
\def\@shortdegree{\ClassError{ucsddissertation}{You must specify a
\protect\degree}{Use \protect\degree}}
\let\@chair\@empty
\let\@cochair\@empty
\let\@committee\@empty
\def\@degreeyear{\ClassError{ucsddissertation}{You must specify a
\protect\degreeyear}{Use \protect\degreeyear}}
\setlength\parindent{.5in}

\def\ucsd@uppercasefirst#1#2\relax{%
	\uppercase{\def\ucsd@temp{#1}}%
	\appto\ucsd@temp{#2}%
}

\newcommand\makefrontmatterpage[2][]{%
	\newenvironment{#2}{%
		\newpage
		\csuse{phantomsection}%
		\ucsd@uppercasefirst#2\relax
		\addcontentsline{toc}{chapter}{\ucsd@temp}%
		\centerline{\uppercase{#2}}%
		#1%
	}{\newpage}%
}
\makefrontmatterpage{dedication}
\makefrontmatterpage{epigraph}
\makefrontmatterpage{preface}
\makefrontmatterpage{acknowledgements}
\makefrontmatterpage[\setsinglespacing]{vita}
\let\makefrontmatterpage\@undefined

\newcommand*\publications{%
	\vskip\baselineskip
	\centerline{PUBLICATIONS}%
	\vskip\baselineskip
}
\newcommand*\fieldsofstudy{%
	\vskip\baselineskip
	\centerline{FIELDS OF STUDY}%
	\vskip\baselineskip
}

\newenvironment{dissertationabstract}{%
	\newpage
	\csuse{phantomsection}%
	\addcontentsline{toc}{chapter}{Abstract of the Dissertation}%
	\begingroup
		\centering
		\setsinglespacing
		\Vspace{1.5in}%
		\strut ABSTRACT OF THE DISSERTATION\par
		\vskip\titleskip
		\@title\par
		\vskip\byskip
		by\par
		\vskip\authorskip
		\@author\par
		\vskip\dissertationabstractskip
		\@shortdegree\ in \@degree\par
		\vskip\dissertationabstractskip
		University of California San Diego, \@degreeyear\par
		\vskip\dissertationabstractskip
		\@chair
		\@cochair
	\endgroup
	\vskip.3333in}{\newpage}

\newenvironment{dissertationintroduction}{%
	\newpage
	\csuse{phantomsection}%
	\addcontentsline{toc}{chapter}{Introduction}%
	\chapter*{Introduction}%
}{%
	\newpage
}

% Facing caption pages
\newbox\ucsd@captionbox
\newenvironment{facingcaption}[1]{%
	\let\ucsd@saved@caption\@caption
	\global\setbox\ucsd@captionbox\box\voidb@x
	\long\def\@caption##1[##2]##3{%
		\global\setbox\ucsd@captionbox\color@vbox\vbox{%
			\ucsd@saved@caption##1[##2]{##3}%
		}\color@endbox
		\def\caption{\ClassError{ucsddissertation}{%
			Only one \noexpand\caption\space per
			facingcaption}{}}%
	}%
	\@xfloat{#1}[p]%
}{%
	\@endfloatbox
	\let\@endfloatbox\relax
	\ifvoid\ucsd@captionbox\else
		\ht\ucsd@captionbox\z@
		\dp\ucsd@captionbox1sp
		\global\setbox\@currbox\vbox{%
			\box\@currbox
			\nointerlineskip
			\box\ucsd@captionbox
			\vskip-1sp
		}%
		\ht\@currbox\textheight
	\fi
	\end@float
}

% Modify the output routine to check for these
\newbox\ucsd@outputcaptionbox
\newbox\ucsd@outputfigurebox
\let\ucsd@saved@wtryfc\@wtryfc
\def\@wtryfc#1{%
	\ifdim\dimexpr\ht\@outputbox + \dp\@outputbox=\z@
		\ucsd@wtryfc{#1}%
	\else
		\ucsd@saved@wtryfc{#1}%
	\fi
}

\def\ucsd@wtryfc#1{%
	\begingroup
	\global\setbox\ucsd@outputcaptionbox\box\voidb@x
	\setbox\z@\vbox{%
		\unvcopy#1%
		\ifdim\lastskip=-1sp
			\unskip
			\setbox\z@\lastbox
			\ifdim\dp\z@=1sp
				\global\setbox\ucsd@outputcaptionbox\vbox{%
					\unvbox\z@
				}%
				\global\setbox\ucsd@outputfigurebox\lastbox
			\fi
		\fi
	}%
	\ifvoid\ucsd@outputcaptionbox
		\ucsd@saved@wtryfc{#1}%
	\else
		\ifdim\dimexpr\ht\z@+\dp\z@>\z@
			\message{Output box not torn apart!}%
		\fi
		\global\setbox\@outputbox\vbox to\textheight{%
			\vfill
			\box\ucsd@outputcaptionbox
			\vfill
			\vfill
		}%
		\ucsd@savespecial
		\ps@facingcaption
		\@specialpagefalse
		\@outputpage
		\ucsd@restorespecial
		\global\setbox\@outputbox\vbox{}%
		\ucsd@saved@wtryfc{\ucsd@outputfigurebox}%
	\fi
	\endgroup
}

\def\ucsd@savespecial{%
	\let\ucsd@specialpage\if@specialpage
}
\def\ucsd@restorespecial{%
	\global\let\if@specialpage\ucsd@specialpage
}

% Fix the broken \@chapter that unconditionally adds space
\def\ucsd@patchfailed{\ClassError{ucsddissertation}{Failed to patch a
command!}{Uh oh}}
\patchcmd{\@chapter}{%
	\addtocontents{lof}{\protect\addvspace{10\p@}}%
	\addtocontents{lot}{\protect\addvspace{10\p@}}%
}{}{}{\ucsd@patchfailed}

% Set up various list ofs
% Use more dots
\renewcommand\cftdotsep{2}
\cftsetpnumwidth{2em}
\newcommand\ucsd@setuptocentry[2]{%
	\csdef{cft#1font}{\normalfont}%
	\csdef{cft#1presnum}{#2\space}%
	\csdef{cft#1dotsep}{\cftdotsep}%
	\csdef{cft#1pagefont}{\normalfont}%
	\csdef{cft#1leader}{\cftdotfill\cftdotsep}%
	\ifstrequal{#1}{chap}{%
		\csdef{cft#1aftersnum}{ }%
		\def\ucsd@temp{00}%
	}{%
		\ifstrequal{#1}{part}{%
			\csdef{cft#1aftersnum}{ }%
			\def\ucsd@temp{VIII}%
		}{%
			\csdef{cft#1aftersnum}{. }%
			\def\ucsd@temp{00.00}%
		}%
	}%
	\csdef{cft#1indent}{\z@}%
	\csdef{cftbefore#1skip}{12\p@}%
	\settowidth\dimen@{%
		\csuse{cft#1presnum}%
		\ucsd@temp
		\csuse{cft#1aftersnum}%
	}%
	\csuse{cft#1numwidth}\dimen@
}

\newcommand\ucsd@setuplistof[5]{%
	\csdef{cft#2titlefont}{%
		\csuse{phantomsection}%
		\addcontentsline{toc}{chapter}{#3}%
		\hfill
		\MakeUppercase
	}%
	\csdef{cftafter#2title}{\hfill\null}%
	\csuse{cftbefore#2titleskip}\z@skip
	\csuse{cftafter#2titleskip}\z@skip
	% Patch the \@cftmakeXtitle commands to remove the extra space
	% inserted by \vspace* by converting it to a \vspace which
	% will ignore the argument because it's the top of a page.
	\edef\ucsd@temp{%
		\noexpand\patchcmd[\long]%
			{\expandafter\noexpand\csname @cftmake#2title\endcsname}%
			{\noexpand\vspace*}{\noexpand\vspace}%
			{}{\noexpand\ucsd@patchfailed}%
	}%
	\ucsd@temp % perform the patch
	\ucsd@setuptocentry{#1}{#4}%
	\AfterPreamble{%
		\preto#5{\newpage\begingroup\setsinglespacing}%
		\appto#5{\endgroup\newpage}%
	}%
}
\ucsd@setuplistof{chap}{toc}\contentsname\@chapapp\tableofcontents
\ucsd@setuplistof{fig}{lof}\listfigurename\figurename\listoffigures
\ucsd@setuplistof{tab}{lot}\listtablename\tablename\listoftables

% Make \part display in a similar fashion to chapter
\ucsd@setuptocentry{part}\partname
% Unfortunately, \@part is defined differently from \@chapter and the
% like. In particular, it doesn't use \numberline which is defined to
% make an \hbox of the appropriate size. Instead, it uses
% \thepart\hspace{1em}#1 which gives a really uneven looking result in
% this format. Let's patch it!
\patchcmd\@part{\addcontentsline{toc}{part}{\thepart\hspace{1em}#1}}
	{\addcontentsline{toc}{part}{\protect\numberline{\thepart}#1}}
	{}{\ucsd@patchfailed}
% Unfortunately (again), this causes problems with tocloft's
% definition of \l@part tries to deal with the above problem by
% inserting a \cftpartpresnum before the title. Coupled with the above
% definition, this gives us (more or less) Part Part I, obviously not
% what we want. Let's patch out this behavior so that \l@part looks
% more like \l@chapter. Since \l@part is defined via \renewcommand*,
% we don't need to insert the \long prefix.
%
% Starting with version 2.3f [2013/05/02] of tocloft, this is
% unnecessary. The \patchcmd cannot be tokenized as part of the
% \@ifpackagelater for some reason. Use \if@ucsdpatchlpart to control
% the decision to patch.
\newif\if@ucsdpatchlpart
\@ifpackagelater{tocloft}{2013/05/02}{\@ucsdpatchlpartfalse}{\@ucsdpatchlparttrue}
\if@ucsdpatchlpart
	\patchcmd\l@part{{\cftpartfont \cftpartpresnum #1}}
		{{\cftpartfont #1}}{}{\ucsd@patchfailed}%
\fi

% Handle \appendix in the table of contents
\appto\appendix{\addtocontents{toc}{\def\string\@chapapp{\string\appendixname}}}
% listings and algorithms are handled after the preamble
\newcommand\ucsd@registerwithtocloft[3]{%
	\begingroup
	\let\newcounter\@gobble
	\def\setcounter##1##2{\endgroup}%
	\cslet{c@#1}\relax
	\newlistof{#1}{#2}{#3}% Also ends the group
}
\AfterEndPreamble{%
	% table of contents
	\renewcommand\contentsname{Table of Contents}%
	% list of listings
	\ifdefined\lstlistlistingname
		% Register listings with tocloft
		\renewcommand\lstlistlistingname{List of Listings}%
		\ucsd@registerwithtocloft{listings}{lol}\lstlistlistingname
		\ucsd@setuplistof{listings}{lol}\lstlistlistingname\lstlistingname\listoflistings
		\let\l@lstlisting\l@listings
		\renewcommand\lstlistoflistings{\listoflistings}%
	\fi
	% list of algorithms
	\ifdefined\listofalgorithms
		% Register algorithm with tocloft
		\ifdefined\ALG@name
			% Handle algorithm package
			\ucsd@registerwithtocloft{algorithm}{loa}\listalgorithmname
			\ucsd@setuplistof{algorithm}{loa}\listalgorithmname\ALG@name\listofalgorithm
		\else\ifdefined\listalgorithmcfname
			% Handle algorithm2e package
			\ucsd@registerwithtocloft{algorithm}{loa}\listalgorithmcfname
			\ucsd@setuplistof{algorithm}{loa}\listalgorithmcfname\algorithmcfname\listofalgorithm
		\fi\fi
		\renewcommand\listofalgorithms{\listofalgorithm}%
	\fi
	\pretocmd\thebibliography{%
		\clearpage
		\setsinglespacing
		\ifdefined\bibsep
			\setlength\bibsep{\baselineskip}%
		\fi
		\csuse{phantomsection}%
		\addcontentsline{toc}{chapter}{\bibname}%
	}{}{\ucsd@patchfailed}%
}

% Set page style for the front matter
\appto\frontmatter{%
	\pagestyle{plain}%
}
% Set page style for the body
\appto\mainmatter{%
	\pagestyle{body}%
}

% Set quotation and quote appropriately
\renewenvironment{quotation}{%
	\par
	\singlespacing
	\list{}{\topsep=\z@
		\partopsep=\z@
		\listparindent=.5in
		\itemindent\listparindent
		\rightmargin=.5in
		\leftmargin=.5in
		\parsep\z@\@plus\p@
	}%
	\item \relax
}{\endlist}

\renewenvironment{quote}{%
	\par
	\singlespacing
	\list{}{\topsep=\z@
		\partopsep=\z@
		\rightmargin=.5in
		\leftmargin=.5in
	}%
	\item \relax
}{\endlist}

% Set up captions. These can be overridden, for example to give
% centered text
\captionsetup{%
	font={stretch=1},
	labelfont=bf,
	format=plain,
	justification=justified,
	singlelinecheck=false,
	figureposition=below,
	labelsep=period,
	tableposition=above}
\captionsetup[listing]{position=above}
\captionsetup[subfloat]{singlelinecheck=true}
\captionsetup[ruled]{labelsep=period}

% Set up sectioning formats
\newcommand\sectioningformatting{%
	\RaggedRightRightskip0\p@\@plus4em
	\setsinglespacing
	\normalfont
	\RaggedRight
}
\titleformat\chapter[display]{\sectioningformatting\huge\bfseries}
	{\chaptertitlename\ \thechapter}{20pt}{}
\titleformat\section{\sectioningformatting\Large\bfseries}
	{\thesection}{1em}{}
\titleformat\subsection{\sectioningformatting\large\bfseries}
	{\thesubsection}{1em}{}
\titleformat\subsubsection{\sectioningformatting\normalsize\bfseries}
	{\thesubsubsection}{1em}{}
\titleformat\paragraph{\sectioningformatting\normalsize\bfseries}
	{\theparagraph}{1em}{}
\titlespacing\paragraph{0pt}{3.25ex plus 1ex minus .2ex}{0pt}

\AfterPreamble{%
	\ifdefined\urlstyle
		\urlstyle{same}%
	\fi
}
% Set double spacing throughout the document except where otherwise
% noted.
\doublespacing

\endinput
% vim: filetype=tex
