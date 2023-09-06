# Email Validation

TLDR;

```objc
NSString *email = @"john.doe_27@example.com.uk";
NSString *regex = @"^(?:(?:(?:(?:[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-])+(?:(?:\\.(?!\\.))?(?:[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-])+)*)|(?:\"(?:[^\"\\\\]|\\\\.)*\"))@(?:(?:[a-zA-Z0-9])+(?:\\.(?:[a-zA-Z0-9])+(?:[a-zA-Z0-9-])*(?:[a-zA-Z0-9]))+))$";
NSPredicate *    pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
BOOL isValidEmail = [pred evaluateWithObject:email];
```

## Local part (RFC 5322 standard) - the part before "@"

- case sensitive, but generally, email providers such as Google have case insensitive emails
- **Non-quoted** valid characters (any location):
  - a-z, A-Z, 0-9
  - !#$%&'*+-/=?^_`{|}~
  - dot (`.`) cannot be placed consecutively or on either ends
- **Quoted** valid characters
  - any ascii characters except quote and backslash
  - quote and backlash can be accepted as long as they are escaped

Using the above constraints, we have:

```objc
NSString *localRegex = @"(?:(?:(?:[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-])+(?:(?:\\.(?!\\.))?(?:[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-])+)*)|(?:\"(?:[^\"\\\\]|\\\\.)*\"))";
```

If we want to breakdown the regex, we have:

```objc
NSString *nonQuotedLocal = nil;

NSString *validCharsNoDotRegex = @"(?:[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-])";
NSString *validChars = [NSString stringWithFormat:@"(?:(?:\\.(?!\\.))?%@+)", validCharsNoDotRegex];

nonQuotedLocal = [NSString stringWithFormat:@"(?:%@+%@*)", validCharsNoDotRegex, validChars];

NSString *quotedLocalRegex = @"(?:\"(?:[^\"\\\\]|\\\\.)*\")";

NSString *localPartRegex = [NSString stringWithFormat:@"(?:%@|%@)", nonQuotedLocal, quotedLocalRegex];
```

## Domain part (RFC 1035 standard) - the part after "@"

- composed of two or more labels separated with dots
- each label can be either sub domain, domain, or top level domain
- label valid characters:
  - a-z, 0-9
  - hypens, but cannot be placed on either ends of the label
- limits:
  - maximum limit of 255
  - each label have a limit of 1 to 63 characters



If we want to breakdown the regex, we have:

```objc
NSString *domainpartRegex = nil;

NSString *alphaNumeric = @"(?:[a-zA-Z0-9])";
NSString *validLabelCharacterNotOnEnds = @"(?:[a-zA-Z0-9-])";

NSString *validLabel = [NSString stringWithFormat:@"(?:\\.%@+%@*%@)", alphaNumeric, validLabelCharacterNotOnEnds, alphaNumeric];

domainpartRegex = [NSString stringWithFormat:@"(?:%@+%@+)", alphaNumeric, validLabel];
```

## Local and domain part combined

Format: `localpart`@`domainpart`

```objc
NSString *email = @"john.doe_27@example.com.uk";

NSString *localRegex = @"(?:(?:(?:[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-])+(?:(?:\\.(?!\\.))?(?:[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-])+)*)|(?:\"(?:[^\"\\\\]|\\\\.)*\"))";

NSString *domainRegex = @"(?:(?:[a-zA-Z0-9])+(?:\\.(?:[a-zA-Z0-9])+(?:[a-zA-Z0-9-])*(?:[a-zA-Z0-9]))+)";

NSString *emailRegex = [NSString stringWithFormat:@"^(?:%@@%@)$",localRegex, domainRegex];

NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", combined];
    

BOOL isValid = [pred evaluateWithObject:email];
```


Regex breakdown:
 - the `localPartRegex` and `domainpartRegex` values are given on previous sections.

```objc
NSString *localAndDomainRegex = [NSString stringWithFormat:@"%@@%@", localPartRegex, domainpartRegex];

NSString *regex = localAndDomainRegex;

NSPredicate *    pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
```

## Test cases

```objc
- (void)testEmailSimple {
    NSArray<NSString *> *emails = @[
        @"user27@example.com",
        @"john.doe@example.com",
        @"jane_doe@example.com",
        @"john.johnny.doe@example.com",
        @"user1@example.com",
        @"john.doe1@example.com",
        @"jane_doe1@example.com",
        @"john.johnny.doe1@example.com",
    ];
    
    for (NSString *email in emails) {
        XCTAssertTrue(email.isEmail, @"Email validation failed for %@", email);
    }
}

- (void)testEmailWithPlusSign {
    NSArray<NSString *> *emails = @[
        @"user+support@example.com",
        @"jane+123@example.com",
        @"info+sales@example.com",
    ];
    
    for (NSString *email in emails) {
        XCTAssertTrue(email.isEmail, @"Email validation failed for %@", email);
    }
}

- (void)testEmailAlphaOnly {
    NSArray<NSString *> *emails = @[
        @"a@b.cd",
        @"a@b.cde",
        @"user@example.com",
        @"user.reuse@example.com",
        @"user.reuse.reduce@example.com",
        @"user.reuse.reduce.recycle@example.com",
        @"qwertyuiopasdfghjklzxcvbnm@example.com",
        @"q.w.e.r.t.y.u.i.o.p.a.s.d.f.g.h.j.k.l.z.x.c.v.b.n.m@example.com",
        @"qwertyuiopasdfghjklzxcvbnm.qwertyuiopasdfghjklzxcvbnm.qwertyuiopasdfghjklzxcvbnm@example.com",
    ];
    
    for (NSString *email in emails) {
        XCTAssertTrue(email.isEmail, @"Email validation failed for %@", email);
    }
}

- (void)testEmailAlphaNumericOnly {
    NSArray<NSString *> *emails = @[
        @"a1@b.cd",
        @"a2@b.cde",
        @"us3er@example.com",
        @"use4r.re5use@example.com",
        @"u7ser.reu6se.r8educe@example.com",
        @"us9er.re0use.red1uce.rec2ycle@example.com",
        @"qwe3rtyuiopasdf4ghjkl5zxc6vbn7m@example.com",
        @"q.w.e.r18.t.y.u.i.o.p.a.s.d.f.19g.h.j.k.l.z.20x.c.v.b21.n.m@example.com",
        @"qwer22tyuiopa23sdfghjklzxc24vbnm.qw25ertyuiopa26sdfghj27klzxc28vbnm.qwerty29uiopasdfghjklzxcvbnm@example.com",
        @"30a@b.cd",
        @"a31@b.cde",
        @"32user9@example.com",
        @"use33r.reuse0@example.com",
        @"5user.reuse.reduce@example1.com",
        @"7user.reuse.reduce.recycle@example.com",
        @"8qwertyuiopasdfghjklzxcvbnm@example.com",
        @"9q.w.e.r.t.y.u.i.o.p.a.s.d.f.g.h.j.k.l.z.x.c.v.b.n.m@example.com",
        @"0qwertyuiopasdfghjklzxcvbnm.qwertyuiopasdfghjklzxcvbnm.qwertyuiopasdfghjklzxcvbnm@example.com",
    ];
    
    for (NSString *email in emails) {
        XCTAssertTrue(email.isEmail, @"Email validation failed for %@", email);
    }
}

///  Local part can contain alphabetic, numeric, and these symbols: !#$%&'*+-/=?^_`{|}~ (RFC 2822, section 3.4.1)
- (void)testEmailWithAllowedSpecialCharacters {
    NSArray<NSString *> *emails = @[
        @"!u!!s!er!@example.com",
        @"#u##s#er#@example.com",
        @"&u&&s&er&@example.com",
        @"$u$$s$er$@example.com",
        @"%u%%s%er%@example.com",
        @"'u''s'er'@example.com",
        @"*u**s*er*@example.com",
        @"+u++s+er+@example.com",
        @"-u--s-er-@example.com",
        @"/u//s/er/@example.com",
        @"=u==s=er=@example.com",
        @"?u??s?er?@example.com",
        @"^u^^s^er^@example.com",
        @"_u__s_er_@example.com",
        @"`u``s`er`@example.com",
        @"{u{{s{er{@example.com",
        @"|u||s|er|@example.com",
        @"}u}}s}er}@example.com",
        @"~u~~s~er~@example.com",
    ];
    
    for (NSString *email in emails) {
        XCTAssertTrue(email.isEmail, @"Email validation failed for %@", email);
    }
}

/// Local part can be enclosed with quotes
///
/// - no character restriction inside quotes as long as it is not a backslash or quote
/// - quoted local part can accepts quotes and backslashes as long as they are preceded by backslash
- (void)testEmailQuoted {
    /*
     "user"@example.com
     "john doe"@example.com
     "jane_doe"@example.com
     "john\\ \\doe"@example.com
     "john\\ doe\"@example.com
     "john \"johnny\" doe"@example.com
     "john \"johnny doe"@example.com
     */
    NSArray<NSString *> *emails = @[
        @"\"user\"@example.com",
        @"\"john doe\"@example.com",
        @"jane_doe@example.com",
        @"\"john\\ \\doe\"@example.com",
        @"\"john\\ doe\"@example.com",
        @"\"john \\\"johnny\\\" doe\"@example.com",
        @"\"john \\\"johnny doe\"@example.com",
    ];
    
    for (NSString *email in emails) {
        XCTAssertTrue(email.isEmail, @"Email validation failed for %@", email);
    }
}

/// - local part of the email address should be interpreted and treated as case-sensitive by the receiving email server (RFC 5321)
/// - in practice, most email providers and servers, including Google ignore case sensitivity
- (void)testEmailCaseInsensitivity {
    NSArray<NSString *> *validEmails = @[
        @"uSeR@example.com",
        @"uSeR.uSEr@example.com",
        @"usEr.useR.usEr@example.com",
        @"usEr_useR+usEr@example.com",
    ];
    
    for (NSString *email in validEmails) {
        XCTAssertTrue(email.isEmail, @"Email validation failed for %@", email);
    }
}

// MARK: - Email Domain part tests

- (void)testEmailWithSubDomain {
    NSArray<NSString *> *emails = @[
        @"info@sub.example.com",
        @"sales@sub.sub.example.com",
        @"contact@sub2.sub1.example.com",
    ];
    
    for (NSString *email in emails) {
        XCTAssertTrue(email.isEmail, @"Email validation failed for %@", email);
    }
}

- (void)testEmailWithDifferentTopLevelDomains {
    NSArray<NSString *> *emails = @[
        @"user@example.co.uk",
        @"contact@example.org",
        @"john.doe@example.net",
        @"user@example.com.ph",
    ];
    
    for (NSString *email in emails) {
        XCTAssertTrue(email.isEmail, @"Email validation failed for %@", email);
    }
}

/// Test with valid top level domains listed by IANA (Internet Assigned Numbers Authority)
///
/// Reference: https://data.iana.org/TLD/tlds-alpha-by-domain.txt
- (void)testEmailWithAllTopLevelDomains {
    NSArray<NSString *> *validEmails = @[
        @"user@example.com.uk",
        @"info@sub.example.com.ph",
        @"contact@sub2.sub1.example.com",
        @"jane+1etic23@example.com.au",
    ];
    
    for (NSString *email in validEmails) {
        for (NSString *tld in self.topLevelDomains) {
            NSString *modifiedEmail = [email stringByReplacingOccurrencesOfString:@".com" withString:[NSString stringWithFormat:@".%@", tld]];
            XCTAssertTrue(modifiedEmail.isEmail, @"Email validation failed for %@", [NSString stringWithFormat:@"%@ - %@", email, modifiedEmail]);
        }
    }
}

// MARK: - Test invalid emails

- (void)testInvalidEmails {
    NSArray<NSString *> *invalidEmails = @[
        @"abc_def.example.com",
        @"user@example",
        @"user@.com",
        @"user@com",
        @"user@name@example.com",
        @"user@name@example..com",
        @"user@example..com",
        @"user..us@example.com",
        @"user...us@example.com",
        @"user..use@example.com",
        @"user..user@example.com",
        @"user...use@example.com",
        @"user.ue..a.se@example.com",
        @"user...user@example.com",
        @"user@example.",
        @"user@com",
        @"user@-example.com",
        @"user@example.com!",
        @"user{at}example.com",
        @"user@example_com",
        @"user@example.com?",
        @"user@example..com",
        @"us\"er@example..com",
        @"us\\er@example..com",
        @"user@examp`le.com",
        @"user@exam~le.com",
        @"user@exam!le.com",
        @"user@exam@le.com",
        @"user@exam#le.com",
        @"user@exam$le.com",
        @"user@exam%le.com",
        @"user@exam^le.com",
        @"user@exam&le.com",
        @"user@exam*le.com",
        @"user@exam(le.com",
        @"user@exam)le.com",
        @"user@exam{le.com",
        @"user@exam}le.com",
        @"user@exam[le.com",
        @"user@exam]le.com",
        @"user@exam|le.com",
        @"user@exam\\le.com",
        @"user@exam/le.com",
        @"user@exam:le.com",
        @"user@exam;le.com",
        @"user@exam\"le.com",
        @"user@exam'le.com",
        @"user@exam<le.com",
        @"user@exam>le.com",
        @"user@exam,le.com",
        @"user@exam?le.com",
        @"user@-examle.com",
        @"user@--exam?le.com",
        @"user@-exam?le.com",
        @"user@.example.com",
        @"user@..example.com",
        @"\"user@exampple.com",
        @"plainaddress", // reference: https://gist.github.com/cjaoude/fd9910626629b53c4d25
        @"#@%^%#$@#$@#.com",
        @"@example.com",
        @"Joe Smith <email@example.com>",
        @"email.example.com",
        @"email@example@example.com",
        @".email@example.com",
        @"email.@example.com",
        @"email..email@example.com",
        @"email@example.com (Joe Smith)",
        @"email@-example.com",
        @"email@example..com",
        @"Abc..123@example.com",
        @"\"(),:;<>[\\]@example.com",
        @"just”not”right@example.com",
        @"this\\ is\"really\"not\allowed@example.com",
    ];
    
    for (NSString *email in invalidEmails) {
        XCTAssertFalse(email.isEmail, @"Email validation failed for %@", email);
    }
}

- (NSArray<NSString *> *)topLevelDomains {
    if (!_topLevelDomains) {
        NSString *path = [[NSBundle bundleForClass:[NSString_Check_isEmailTests class]] pathForResource:@"top-level-domain-list" ofType:@"json"];
        NSError *error = nil;
        NSData *data = [NSData dataWithContentsOfFile:path options:NSDataReadingMapped error:&error];
        
        if (error != nil) {
            NSLog(@"xx-> %@", error);
        }
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        NSMutableArray<NSString *> *mutable = [NSMutableArray array];
        for (NSString *tld in array) {
            [mutable addObject:tld.lowercaseString];
        }
        _topLevelDomains = mutable;
    }
    return _topLevelDomains;
}

@end
```

## References
- https://emailregex.com/email-validation-summary/
- https://stackoverflow.com/questions/201323/how-can-i-validate-an-email-address-using-a-regular-expression
- https://en.wikipedia.org/wiki/Email_address
- http://www.iana.org/domains/root/db
- https://data.iana.org/TLD/tlds-alpha-by-domain.txt
- https://gist.github.com/cjaoude/fd9910626629b53c4d25