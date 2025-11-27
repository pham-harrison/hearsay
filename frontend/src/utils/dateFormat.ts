const monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

export default function dateFormat(dateStr: string) {
  const dateObj = new Date(dateStr);
  return monthNames[dateObj.getMonth()] + " " + dateObj.getDate() + ", " + dateObj.getFullYear();
}
