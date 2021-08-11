-- -----------------------------------------------------------------------
-- UPDATE SENDER
-- -----------------------------------------------------------------------
ALTER TABLE sender
    ADD COLUMN email_since_epoch INTEGER,
    ADD COLUMN ignore_until_epoch INTEGER;