enum ActiveStatus { initial, loaded, error, loading, action }

enum DeviceAssignFor {
  development("Development"),
  testing("Testing"),
  unAssigned("Unassign");

  final String name;
  const DeviceAssignFor(this.name);
}
