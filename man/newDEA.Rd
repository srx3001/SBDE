% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DifferentialExpressionAnalysis.R
\name{newDEA}
\alias{newDEA}
\title{New Differential Expression Analysis}
\usage{
newDEA(analysis_title, token, project_id, platform, align_wf, de_wf)
}
\arguments{
\item{analysis_title}{the title of your analysis}

\item{token}{your Seven Bridges Platform authentication token}

\item{project_id}{project id}

\item{platform}{chosen Seven Bridges platform}

\item{align_wf}{a character string indicating the choice of alignment workflow
(choose between \emph{star}, \emph{tophat2} and \emph{hisat2})}

\item{de_wf}{a character string indicating the choice of quantification/DE workflow
(choose between \emph{cufflinks} and \emph{deseq2})}
}
\value{
The output is a new \code{DifferentialExpressionAnalysis} object,
  with \emph{title}, \emph{project}, \emph{alignment_wf} and \emph{quantification_DE_wf}
  slots populated. Also, any FASTA or FA files found in the project are going to be listed
  in the \emph{reference} slot - change the value manually if needed so it reflects your
  choice of reference. Same goes for the \emph{annotation} and \emph{sample_reads} slots.
  Ideally, you will create a new project for the analysis and import just the desired
  FASTQs, a single FASTA and a single GTF file.
}
\description{
\code{newDEA} creates a new object of class \code{DifferentialExpressionAnalysis}.
}
\examples{
testDEA <- newDEA("Hisat_and_deseq2", your_token, your_project, your_platform, "hisat2", "deseq2")
}
