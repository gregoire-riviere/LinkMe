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
    ]
]