\name{AT.particle.no.from.particle.name}
\alias{AT.particle.no.from.particle.name}
\title{AT.particle.no.from.particle.name}
\description{Returns particle index number(s) for given particle names(s)
}
\usage{AT.particle.no.from.particle.name(particle.name)
}
\arguments{
  \item{particle.name}{ particle name(s) (see also \code{\link{particle.name}}).}
}
\value{
  \item{particle.no}{ particle index number(s) (see also \code{\link{particle.no}}).}
}

\examples{
# Get particle names for some nuclides
AT.particle.no.from.particle.name( particle.name     = c("1H", "2H", "3He", "12C", "16O","238U"))
}


