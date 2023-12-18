import { argv } from "process";
import { DateTime } from "luxon";

const args = argv.slice(2);

let timestamp = parseTimestamp(args[0]);
const tz = args[1];

const date = DateTime.fromMillis(timestamp);

field("Timestamp", timestamp);
field("Epoch", Math.floor(timestamp / 1000));
printDate(date, "utc");
printDate(date, "local");

if (tz) {
  printDate(date, "tz");
}

function parseTimestamp(text) {
  if (!text || text === "now") return Date.now();

  const asIso = DateTime.fromISO(text);
  if (asIso.isValid) {
    return asIso.valueOf();
  }

  const timestamp = parseFloat(text);
  return timestamp < 10000000000 ? timestamp * 1000 : timestamp;
}

function printDate(date, tz) {
  const zonedDate = date.setZone(tz);
  const formatted = zonedDate.toISO(); //.toFormat('yyyy-MM-dd HH:mm:ss.SSS ZZ')
  field(zonedDate.zone.name, formatted);
}
function field(label, value) {
  console.log(label.padEnd(20), value);
}
