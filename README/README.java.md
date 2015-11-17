# Check system time zones

## Create file

checktz.sh

```
  #!/bin/sh
  T1=$(LC_ALL=C TZ=Europe/Moscow date -d @1409067890)
  if [ "$T1" != 'Tue Aug 26 19:44:50 MSK 2014' ] ; then
      echo FAIL! Wrong TZ BEFORE 26 Oct 2014!
      exit 1
  fi
  T2=$(LC_ALL=C TZ=Europe/Moscow date -d @1416667890)
  if [ "$T2" != 'Sat Nov 22 17:51:30 MSK 2014' ] ; then
      echo FAIL! Wrong TZ AFTER 26 Oct 2014!
      exit 2
  fi
  echo OK
```

## Check

chmod a+x checktz.sh

./checktz.sh


# Java. Update time zones

Download from oracle.com "Java Time Zone Updater Tool"

```
sudo java -jar tzupdater.jar -u
```

## Create file

tzcheck.java

```
  import java.util.*;
  import java.text.DateFormat;
  public class tzcheck {
      public static void main(String[] args) {
          Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("Europe/Moscow"));
          DateFormat df = DateFormat.getDateTimeInstance(DateFormat.FULL, DateFormat.FULL, Locale.US);
          df.setCalendar(cal);
          cal.setTimeInMillis(1409067890L * 1000L);
          if (!df.format(cal.getTime()).equals("Tuesday, August 26, 2014 7:44:50 PM MSK")) {
              System.out.println("FAIL! Wrong TZ BEFORE 26 Oct 2014!");
              System.exit(1);
          }
          cal.setTimeInMillis(1416667890L * 1000L);
          if (!df.format(cal.getTime()).equals("Saturday, November 22, 2014 5:51:30 PM MSK")) {
              System.out.println("FAIL! Wrong TZ AFTER 26 Oct 2014!");
              System.exit(2);
          }
          System.out.println("OK");
          System.exit(0);
      }
  }
```

# Check

javac tzcheck.java

java tzcheck

# Select version

sudo update-alternatives --config java

