/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
-- -----------------------------------------------------------------------
-- COMPANY
-- -----------------------------------------------------------------------
CREATE TABLE company (
     company_id INTEGER PRIMARY KEY AUTOINCREMENT,
     logo TEXT,
     security_score REAL,
     breach_score REAL,
     sensitivity_score REAL,
     domain TEXT,
     created_epoch INTEGER NOT NULL,
     modified_epoch INTEGER NOT NULL
);

-- -----------------------------------------------------------------------
-- SENDER
-- -----------------------------------------------------------------------
CREATE TABLE sender (
    sender_id INTEGER PRIMARY KEY AUTOINCREMENT,
    company_id INTEGER,
    name TEXT,
    email TEXT UNIQUE,
    category TEXT,
    unsubscribe_mail_to TEXT,
    ignore_until_epoch INTEGER,
    email_since_epoch INTEGER,
    updated_epoch INTEGER,
    unsubscribed_bool INTEGER,
    created_epoch INTEGER NOT NULL,
    modified_epoch INTEGER NOT NULL,
    FOREIGN KEY(company_id) REFERENCES company(company_id)
);


-- -----------------------------------------------------------------------
-- MESSAGE
-- -----------------------------------------------------------------------
CREATE TABLE message (
    message_id INTEGER PRIMARY KEY AUTOINCREMENT ,
    ext_message_id TEXT NOT NULL,
    sender_id INTEGER NOT NULL,
    received_date_epoch INTEGER,
    opened_date_epoch INTEGER,
    account TEXT,
    created_epoch INTEGER NOT NULL,
    modified_epoch INTEGER NOT NULL,
    FOREIGN KEY (sender_id) REFERENCES sender(sender_id),
    UNIQUE (ext_message_id, account)
);