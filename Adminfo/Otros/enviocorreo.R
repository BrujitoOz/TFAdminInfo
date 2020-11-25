
send.mail(from = "u201822706@upc.edu.pe",
          to = c("ozemblem66@gmail.com"),
          subject = "Test",
          body = "Alo",
          smtp = list(host.name = "u201822706@upc.edu.pe", port =465,
                      user.name = "u201822706@upc.edu.pe",
                      passwd = "mypass", ssl=TRUE),
          authenticate = TRUE,
          send = TRUE,
          debug = TRUE)
