% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/alf_session.R
\name{alf_session.invalidate}
\alias{alf_session.invalidate}
\title{Invalidates a session.}
\usage{
alf_session.invalidate(session)
}
\arguments{
\item{session}{session}
}
\value{
\code{TRUE} if session has been successfully invalidated, \code{FALSE} if session was
already invalid.
}
\description{
Invalidates a valid session so it can no longer be used to connect to an Alfresco repository.
}
\examples{
# try to establish a connection to the alfresco content repository
my_session <-
  tryCatch(
    alf_session("http://localhost:8080", "admin", "admin"),
    error = function(e) NULL)

if (!is.null(my_session)) {

  # output session information
  print(paste("Session: [ticket = ", my_session$ticket,
                      ", server = ", my_session$server, "]", sep=""))

  # verify that the session is valid
  if (alf_session.is_valid(my_session)) print("Session verified as valid.")

  # invalidate the session so that it can no longer be used
  alf_session.invalidate(my_session)
}
}
