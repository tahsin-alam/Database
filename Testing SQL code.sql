-- Something like the following will initialize postgres and create a database
-- on a unix-like operating system:

-- $ sudo -u postgres -i
-- $ initdb --locale $LANG -E UTF8 -D '/var/lib/postgres/data'
-- $ systemctl start postgres.service
-- $ createuser --interactive
-- $ createdb myDatabaseName
-- $ psql -d myDatabaseName

-- SQL is for the most part case insensitive.
-- Whitespace is not significant, but you will often see SQL formated similarly
-- to the code in this file.

-- Create a relation by specifying a schema.
CREATE TABLE phonebook(
    phone VARCHAR(32),
    firstname VARCHAR(32),
    lastname VARCHAR(32),
    address VARCHAR(64)
);

-- Add tuple to a relation with `insert`.
INSERT INTO phonebook(
    phone,
    firstname,
    lastname,
    address
)
VALUES (
    '+1 123 456 7890',
    'John',
    'Doe',
    'North America'
);
-- Mind the single quotes!

INSERT INTO phonebook(
    phone,
    firstname,
    lastname,
    address
)
VALUES (
    '+1 555 555 5555',
    'John',
    'Connor',
    'North America'
);

INSERT INTO phonebook(
    phone,
    firstname,
    lastname,
    address
)
VALUES (
    '+1 444 444 4444',
    'Julia',
    'Childs',
    'North America'
);

-- Unless the attribute is constrained, it does not need to be specified.
INSERT INTO phonebook(
    phone,
    firstname,
    address
)
VALUES (
    '011+39 777 777 7777',
    'Foo',
    'Italy'
);

-- We can update the table to require all of the fields.
ALTER TABLE phonebook ALTER COLUMN lastname SET NOT NULL;
-- But of course that won't work unless we *update* `Foo` to have a lastname.

-- UPDATE phonebook SET lastname = 'Bar' where firstname = 'Foo';
ALTER TABLE phonebook ALTER COLUMN firstname SET NOT NULL;
ALTER TABLE phonebook ALTER COLUMN address SET NOT NULL;
ALTER TABLE phonebook ADD PRIMARY KEY (phone);
*/

-- Now we will create a `call log` that records what calls you have made,
-- but this time we will define the constraints along with the schema.
CREATE TABLE calllog(
    phone VARCHAR(32),
    madeat TIMESTAMP WITH TIME ZONE
);

INSERT INTO calllog(
	madeat,
    phone
) VALUES (
 	'2004-10-19 10:23:54+02',
    '011+39 777 777 7777'
);

SELECT calllog.phone, calllog.madeat, phonebook.firstname, phonebook.lastname
FROM calllog, phonebook
WHERE calllog.phone = phonebook.phone;

-- But what happens now?
INSERT INTO calllog(
    phone,
	madeat
)
VALUES (
    '123',
 	'2005-10-19 10:23:54+02'
);

SELECT calllog.phone, calllog.madeat, phonebook.firstname, phonebook.lastname
FROM calllog, phonebook
WHERE calllog.phone = phonebook.phone;

-- We can add a "foreign key constraint" to this table that requires the phone
-- numbers in the calllog relation to be in the phonebook relation.
-- We could update the table as before, or we can "drop" the table and then
-- start over.
DROP TABLE calllog;
-- or we could just drop the bad data
-- DELETE FROM calllog WHERE phone='123';
--ALTER TABLE phonebook ADD PRIMARY KEY (phone);
CREATE TABLE calllog(
    phone VARCHAR(32) REFERENCES phonebook(phone),
    madeat TIMESTAMP WITH TIME ZONE
);

-- So now we can't enter bad data like this:
INSERT INTO calllog(
    phone,
	madeat
)
VALUES (
    '123',
 	'2005-10-19 10:23:54+02'
);

