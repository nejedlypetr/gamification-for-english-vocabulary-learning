import 'package:em_widgets/em_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'default', type: EmIconButton)
Widget buildIconButtonUseCase(BuildContext context) {
  return EmIconButton(Icons.add, onPressed: () {});
}

@widgetbook.UseCase(name: 'default', type: EmPrimaryButton)
Widget buildPrimaryButtonUseCase(BuildContext context) {
  return EmPrimaryButton(
    onPressed: () {},
    isLoading: context.knobs.boolean(label: 'Is Loading'),
    isDisabled: context.knobs.boolean(label: 'Is Disabled'),
    text: context.knobs.string(label: 'Text', initialValue: 'Click me'),
    size: context.knobs.list(label: 'Size', options: PrimaryButtonSize.values),
    variant: context.knobs.list(
      label: 'Variant',
      options: PrimaryButtonVariant.values,
    ),
    prefixIcon: context.knobs.listOrNull(
      label: 'Prefix Icon',
      options: [Icons.check],
    ),
  );
}

@widgetbook.UseCase(name: 'default', type: EmMatchButton)
Widget buildMatchButtonUseCase(BuildContext context) {
  return SizedBox.square(
    dimension: 200,
    child: EmMatchButton(
      text: context.knobs.string(label: 'Text', initialValue: 'Click me'),
      onPressed: () {},
      variant: context.knobs.list(
        label: 'Variant',
        options: MatchButtonVariant.values,
      ),
    ),
  );
}
