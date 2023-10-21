[
    logger: [
        backends: [{LoggerFileBackend, :info_log}, {LoggerFileBackend, :debug_log}, :console],
        info_log: [
            path: "logfile.log",
            level: :info
        ],
        debug_log: [
            path: "logfile_debug.log",
            level: :debug
        ]
    ],
    html_handler:
    [
        directories: %{
            html: "web/",
            js: "web/assets/js/",
            css: "web/assets/css/",
            dir_to_copy: ["web/assets/img", "web/assets/font"],
            output: "web_build/",  
        },
        templatization?: true
    ]
]