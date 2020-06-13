package com.google.shinyay.controller

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController
import java.net.InetAddress

@RestController
class HelloController {
    val hostInfo = InetAddress.getLocalHost().hostAddress

    @GetMapping("/")
    fun hello() = "Hello from $hostInfo"
}