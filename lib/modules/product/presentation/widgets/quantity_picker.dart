import 'package:checkout/constants/app_dimens.dart';
import 'package:checkout/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class QuantityPicker extends StatelessWidget {
  final int quantity;
  final Function(int quantity) onPressed;

  const QuantityPicker({
    super.key,
    required this.quantity,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          _buildSpinButton(
            const Icon(Icons.remove_outlined),
            -1,
            disabled: quantity == 1,
          ),
          const SizedBox(
            width: AppDimens.defaultMargin,
          ),
          SizedBox(
            width: AppDimens.quantityPickerQuantityWidth,
            child: Text(
              quantity.toString(),
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge,
            ),
          ),
          const SizedBox(
            width: AppDimens.defaultMargin,
          ),
          _buildSpinButton(
            const Icon(Icons.add_outlined),
            1,
            disabled: false,
          ),
        ],
      );

  Widget _buildSpinButton(
    Widget icon,
    int toSum, {
    required bool disabled,
  }) {
    return SizedBox(
      width: AppDimens.quantityPickerButtonSize,
      height: AppDimens.quantityPickerButtonSize,
      child: ElevatedButton(
        onPressed: disabled ? null : () => onPressed(quantity + toSum),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: icon,
      ),
    );
  }
}
