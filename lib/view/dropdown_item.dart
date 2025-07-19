import 'package:flutter/material.dart';

class DropdownItem {
  final String title;
  final IconData icon;
  final Color? iconColor;
  final VoidCallback
      onTap; // voidcallbakc = void Function() hàm không có tham số và không trả về giá trị
  final bool isSelected;

  DropdownItem({
    required this.title,
    required this.icon,
    this.iconColor,
    required this.onTap,
    required this.isSelected,
  });
}

class CustomDropdownWidget extends StatelessWidget {
  final String title;
  final IconData leadingIcon;
  final Color? leadingIconColor;
  final bool isExpanded;
  final VoidCallback onHeaderTap;
  final List<DropdownItem> items;
  const CustomDropdownWidget({
    super.key,
    required this.title,
    required this.leadingIcon,
    this.leadingIconColor,
    required this.isExpanded,
    required this.onHeaderTap,
    required this.items,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Column(
      children: [
        GestureDetector(
            onTap: onHeaderTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.colorScheme.onSurface.withOpacity(0.2),
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: theme.cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? Colors.black.withOpacity(0.3)
                          : Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    )
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        leadingIcon,
                        color: leadingIconColor ?? theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        title,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ],
              ),
            )),
        if (isExpanded)
          Column(
            children: [
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: theme.colorScheme.onSurface.withOpacity(0.1),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isDark
                            ? Colors.black.withOpacity(0.3)
                            : Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      )
                    ]),
                child: Column(
                  //lặp qua List có cả chỉ số (index) và giá trị (element).
                  //entries trả về Iterable Iterable là một interface (giao diện) đại diện cho một tập hợp các phần tử có thể duyệt được từng cái một (one-by-one).
                  /*
                  List<T> và Set<T> là con của Iterable<T> → dùng được .map(), .where(), .forEach(), v.v.
                  Map<K, V> không phải là Iterable.
                  Nhưng:
                  map.keys trả về Iterable<K>
                  map.values trả về Iterable<V>
                  map.entries trả về Iterable<MapEntry<K, V>>
                  */
                  children: items.asMap().entries.map((entry) {
                    int index = entry.key;
                    DropdownItem item = entry.value;

                    return Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            item.icon,
                            color: item.iconColor,
                          ),
                          title: Text(
                            item.title,
                            style: theme.textTheme.bodyLarge,
                          ),
                          trailing: item.isSelected
                              ? Icon(
                                  Icons.check,
                                  color: theme.colorScheme.primary,
                                )
                              : null,
                          // selected: item.isSelected,
                          // selectedTileColor:
                          //     theme.colorScheme.primary.withOpacity(0.1),
                          onTap: item.onTap,
                        ),
                        if (index < items.length - 1)
                          Divider(
                            height: 1,
                            color: theme.colorScheme.onSurface.withOpacity(0.1),
                          ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
