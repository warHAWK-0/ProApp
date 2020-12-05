class Filter {
  final String departmentFilter;
  final String complaintFilter;
  final String statusFilter;
  final String fromDateFilter;
  final String toDateFilter;
  final String sortByFilter;

  Filter(
      {this.departmentFilter,
      this.complaintFilter,
      this.statusFilter,
      this.fromDateFilter,
      this.toDateFilter,
      this.sortByFilter});
}
