import 'package:checkout/constants/app_dimens.dart';
import 'package:checkout/extensions/context_extensions.dart';
import 'package:checkout/modules/core/presentation/widgets/margin.dart';
import 'package:flutter/material.dart';

class QuantityPicker extends StatelessWidget {
  final int quantity;
  final double inputWidth;
  final Function(int quantity) onPressed;

  const QuantityPicker({
    super.key,
    required this.quantity,
    required this.onPressed,
    this.inputWidth = AppDimens.quantityPickerInputWidth,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          _buildSpinButton(
            const Icon(Icons.remove_outlined),
            -1,
            disabled: quantity == 1,
          ),
          const HorizontalMargin(),
          SizedBox(
            width: inputWidth,
            child: Text(
              quantity.toString(),
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge,
            ),
          ),
          const HorizontalMargin(),
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
