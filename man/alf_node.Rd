% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/alf_node.R
\name{alf_node}
\alias{alf_node}
\title{Get Alfresco node}
\usage{
alf_node(session, node_id = "-root-", relative_path = NULL)
}
\arguments{
\item{session}{valid Alfresco repository session}

\item{node_id}{node id, defaults to \code{-root-}}

\item{relative_path}{relative path from \code{node_id} to required node, defaults to \code{NULL}}
}
\value{
Node details
}
\description{
Gets the details of an Alfresco repository node matching \code{node_id} or, if provided, the node at \code{relative_path}
relative to \code{node_id}.
}
\examples{
# try to establish a connection to the alfresco content repository
my_session <- tryCatch(
                alf_session("http://localhost:8080", "admin", "admin"),
                error = function(e) NULL)

if (!is.null(my_session)) {

  # create document
  my_new_document <- alf_node.new(my_session, node_id="-root-",
    list(
      name = "example.txt",
      nodeType = "cm:content",
      relativePath = "example"
    ))

  # upload content
  my_new_document$content$update(
    system.file("extdata", "sample.txt", package="alfr"))

  # get details of document node
  my_document <- alf_node(my_session, relative_path = "example/example.txt")

  # output the name of the document
  print(my_document$name)

  # output the details of documents content
  print(my_document$content$mime_type)
  print(my_document$content$mime_type_name)
  print(my_document$content$size)
  print(my_document$content$encoding)

  # read document content
  my_content_file <- file(my_document$content$as.file(), "r")
  my_content <- readLines(my_content_file)
  close(my_content_file)
  print(my_content)

  # upload new content
  my_updated_document <- my_document$content$update(
    system.file("extdata", "modified_sample.txt", package="alfr"))

  # print updated content size
  print(my_updated_document$content$size)

  # delete document
  alf_node.delete(my_session, my_document$id)
}
}
